Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265321AbTLNBBX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 20:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265322AbTLNBBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 20:01:23 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:3680 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S265321AbTLNBBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 20:01:19 -0500
Message-ID: <3FDBB651.3080706@yahoo.es>
Date: Sat, 13 Dec 2003 20:01:05 -0500
From: Roberto Sanchez <rcsanchez97@yahoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 vs 2.6
References: <20031201062052.GA2022@frodo> <Pine.LNX.4.44.0312011202330.13692-100000@logos.cnet> <m2r7z8xl2o.fsf_-_@tnuctip.rychter.com>
In-Reply-To: <m2r7z8xl2o.fsf_-_@tnuctip.rychter.com>
X-Enigmail-Version: 0.81.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD645CCB9F8016F81BD3737BB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD645CCB9F8016F81BD3737BB
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jan Rychter wrote:
>>>>>>"Marcelo" == Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:
> 
> [...]
>  Marcelo> 2.6 is already stable enough for people to use it.
> 
> Yes, that's an old post I'm responding to, but I've just given 2.6 a try
> on my desktop machine, and the above statement seems even more
> annoying. I hit the following problems:
> 
>   -- I had to wrestle ATI drivers into compiling, they finally did, but
>      the kernel prints scary-looking warnings with call stacks, about
>      "sleeping function called from invalid context at mm/slab.c:1856,
I have an nForce2 w/ Radeon 9000.  No problems w/ DRI drivers (included
in kernel) or thi ATI supplied drivers, which ATI says successfully
compiled against 2.6.0-test6.

>   -- modules don't autoload for some reason (though I'm sure that could
>      be solved),
Make sure you have all the different module options turned on.  In 2.6
there are different options for loading, unloading and force unloading
modules.

>   -- bttv does not compile, so no video input for me,
I don't know anything about video input.  Did you try Google?

>   -- drivers for my telephony card (from Digium) are not 2.6-ready, so
>      no telephony support for me,
I don't know anything about telephony.  Did you try Google?

>   -- I have just frozen the machine hard by copying files over NFS and
>      doing a simulation write to an ATAPI CD-RW at the same time.
What CPU/chipset do you have?  There are timing issues with nForce2
and AMD CPUs.  A quick search of the LKML archives will yield lots
of discussion and patcheson this issue.

> 
> I haven't even gotten to VMware and user-mode Linux, which I also need,
> and I'm not even dreaming about getting my scanner to work. Not to
> mention that on my laptop there would be an entirely different set of
> issues, and software suspend in 2.6 is, well, still lacking.
VMWare won't work (according to the VMWare tech support people), but
they will (probably) support 2.6 kernels in their next point release.
I assume you are talking about their workstation product.  SWSusp
works fine on my laptop.

> 
> So, as for me, 2.6 is a definite no-no. I see no advantage whatsoever in
> running it, it caused me nothing but pain, and there is no improvement
> that I could see that would justify the upgrade.
But there is plenty of improvement for plenty of people.

> 
> So please be careful when making statements like that. 2.6 is *NOT*
> stable enough nor ready enough for people to use it, unless those people
> have a narrow range of hardware on which the 2.6 kernel has actually
> been tested (translation: they have the same hardware as the main
> developers do).
I doubt I have the same hardware as the main developers, but I did
read the documentation.  Did you?  Even if it is stable enough for
most people, it is still a beta kernel.

> 
> --J.

-Roberto.

--------------enigD645CCB9F8016F81BD3737BB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQE/27ZeTfhoonTOp2oRAgjxAKCS5Qw8HTyPM0G/53Pw82a0TlFNAgCfZW6m
EfX77yxMRPyLkOYOjD9qsro=
=FHlB
-----END PGP SIGNATURE-----

--------------enigD645CCB9F8016F81BD3737BB--

