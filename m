Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVANDZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVANDZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVANDWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:22:02 -0500
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:15314 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261896AbVANDTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 22:19:24 -0500
Message-ID: <41E739F4.1030902@kolivas.org>
Date: Fri, 14 Jan 2005 14:18:12 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Davis <paul@linuxaudiosystems.com>, nickpiggin@yahoo.com.au,
       lkml@s2y4n2c.de, rlrevell@joe-job.com, arjanv@redhat.com, joq@io.com,
       chrisw@osdl.org, mpm@selenic.com, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <1105669451.5402.38.camel@npiggin-nld.site>	<200501140240.j0E2esKG026962@localhost.localdomain> <20050113191237.25b3962a.akpm@osdl.org>
In-Reply-To: <20050113191237.25b3962a.akpm@osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3E3CE20CB674F3352EB7756C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3E3CE20CB674F3352EB7756C
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Paul Davis <paul@linuxaudiosystems.com> wrote:
> 
>>>SCHED_FIFO and SCHED_RR are definitely privileged operations and you
>>
>>this is the crux of what this whole debate is about. for all of you
>>people who think about linux on multi-user systems with network
>>connectivity, running servers and so forth, this is clearly a given.
>>
>>but there is large and growing body of machines that run linux where
>>the sole human user of the machine has a strong and overwhelming
>>desire to have tasks run with the characteristics offered by
>>SCHED_FIFO and/or SCHED_RR. are they still "privileged" operations on
>>this class of linux system? what about linux installed on an embedded
>>system, with a small LCD screen and the sole purpose of running audio
>>apps live? are they still privileged then?
>>
> 
> 
> Paul.  Everyone agrees with you.  I think.  We just need to work out
> the best way of doing it.
> 
> Would I be right in suspecting that we know what to do, but nobody has
> stepped up to write the code?  It's kinda looking like that?

I thought I made it clear i had already volunteered. I was after a 
response to my proposal for how to do it.

Cheers,
Con

--------------enig3E3CE20CB674F3352EB7756C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5zn0ZUg7+tp6mRURAvFEAJ4/s21AFtn7Iv20a88O6BbOnVJkWwCfRvrf
6+q0uTXHgfWuO2+v/f9BiYk=
=6hD2
-----END PGP SIGNATURE-----

--------------enig3E3CE20CB674F3352EB7756C--
