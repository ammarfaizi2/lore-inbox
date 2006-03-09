Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWCIAIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWCIAIM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWCIAIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:08:12 -0500
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:45484 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932285AbWCIAIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:08:10 -0500
References: <200603081013.44678.kernel@kolivas.org> <200603081322.02306.kernel@kolivas.org> <1141784834.767.134.camel@mindpipe> <200603081330.56548.kernel@kolivas.org> <b8bf37780603071852r6bf3821fr7610597a54ad305b@mail.gmail.com> <cone.1141787137.882268.19235.501@kolivas.org> <1141852064.21958.28.camel@localhost> <cone.1141858802.179786.26372.501@kolivas.org> <1141861694.21958.66.camel@localhost>
Message-ID: <cone.1141862870.463023.26372.501@kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Zan Lynx <zlynx@acm.org>
Cc: =?ISO-8859-1?B?QW5kcuk=?= Goddard Rosa <andre.goddard@gmail.com>,
       Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: [PATCH] mm: yield during swap prefetching
Date: Thu, 09 Mar 2006 11:07:50 +1100
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-kolivas.org-26372-1141862870-0003";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-kolivas.org-26372-1141862870-0003
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Zan Lynx writes:

> On Thu, 2006-03-09 at 10:00 +1100, Con Kolivas wrote:
>> Zan Lynx writes:
> [snip]
>> > Games and real-time go together like they were made for each other.
>> 
>> I guess every single well working windows game since the dawn of time is 
>> some sort of anomaly then.
> 
> Yes, those Windows games are anomalies that rely on the OS scheduling
> them AS IF they were real-time, but without actually claiming that
> priority.
> 
> Because these games just assume they own the whole system and aren't
> explicitly telling the OS about their real-time requirements, the OS has
> to guess instead and can get it wrong, especially when hardware
> capabilities advance in ways that force changes to the task scheduler
> (multi-core, hyper-threading).  And you said it yourself, many old games
> don't work well on dual-core systems.
> 
> I think your effort to improve the guessing is a good idea, and
> thanks.  
> 
> Just don't dismiss the idea that games do have real-time requirements
> and if they did things correctly, games would explicitly specify those
> requirements.

Games worked on windows for a decade on single core without real time 
scheduling because that's what they were written for. 

Now that games are written for windows with dual core they work well - again 
without real time scheduling. 

Why should a port of these games to linux require real time?

Cheers,
Con


--=_mimegpg-kolivas.org-26372-1141862870-0003
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBED3HWZUg7+tp6mRURAg+1AJ0fB36N1qlMehnrYtdGfyepc2yd8QCggPBB
paa/Q/lzpQGBwsahcK+7omo=
=9TQX
-----END PGP SIGNATURE-----

--=_mimegpg-kolivas.org-26372-1141862870-0003--
