Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUJIFX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUJIFX5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 01:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUJIFX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 01:23:57 -0400
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:16800 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266498AbUJIFXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 01:23:54 -0400
Message-ID: <416775CD.70706@kolivas.org>
Date: Sat, 09 Oct 2004 15:23:25 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: voluntary-preempt-2.6.9-rc3-mm3-T3
References: <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>	 <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>	 <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>	 <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>	 <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu>	 <20041007105230.GA17411@elte.hu>	 <1097297824.1442.132.camel@krustophenia.net>	 <cone.1097298596.537768.1810.502@pc.kolivas.org> <1097299260.1442.142.camel@krustophenia.net>
In-Reply-To: <1097299260.1442.142.camel@krustophenia.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3B5A7B0764F63CD37FAE3974"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3B5A7B0764F63CD37FAE3974
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Lee Revell wrote:
> On Sat, 2004-10-09 at 01:09, Con Kolivas wrote:
> 
>>Lee Revell writes:
>>
>>
>>>On Thu, 2004-10-07 at 06:52, Ingo Molnar wrote:
>>>
>>>>i've released the -T3 VP patch:
>>>>
>>>>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm3-T3
>>>>
>>>
>>>With VP and PREEMPT in general, does the scheduler always run the
>>>highest priority process, or do we only preempt if a SCHED_FIFO process
>>>is runnable?
>>
>>Always the highest priority runnable.
>>
> 
> 
> Hmm, interesting.  Would there be any advantage to a mode where only
> SCHED_FIFO tasks can preempt?  This seems like a much lighter way to
> solve the realtime problem.

No, the linux scheduler has always been preemptible. PREEMPT and VP just 
allows it to preempt kernel code paths as well. It could be modified to 
do such a thing but apart from real time applications it would perform 
very badly overall.

Con

--------------enig3B5A7B0764F63CD37FAE3974
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBZ3XQZUg7+tp6mRURAsyYAJ9saHlEMr/Nzn6tQRv6GDdnujN0yQCfbTet
gJfFBjApgaUtNleYk1+reJ4=
=Wjwh
-----END PGP SIGNATURE-----

--------------enig3B5A7B0764F63CD37FAE3974--
