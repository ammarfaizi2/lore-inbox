Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWCWLk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWCWLk1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 06:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWCWLk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 06:40:26 -0500
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:438 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751199AbWCWLk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 06:40:26 -0500
References: <200603202145.31464.kernel@kolivas.org> <20060323113118.GA9329@spherenet.spherevision.org>
Message-ID: <cone.1143114017.303805.31285.501@kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Rodney Gordon II <meff@pobox.com>
Cc: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>
Subject: Re: [ck] 2.6.16-ck1
Date: Thu, 23 Mar 2006 22:40:17 +1100
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-kolivas.org-31285-1143114017-0004";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-kolivas.org-31285-1143114017-0004
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Rodney Gordon II writes:

> Good job Con, on your patches.. As far as the kernel in general, I'd
> like to post some warnings:

Thanks.

> Adaptive readahead: I had probs with this before, and I still do.. On
> a desktop if you have odd problems (nothing responding for SECONDS,
> very slow disk I/O during heavy I/O, etc..) disable it.

I was concerned about that myself which is why the only reason I included it 
was because it came in a configurable form where you could choose to enable 
it, and the default was off, and the config option even said suitable to 
_servers_, not desktops.

> The new Yukon2 "sky2" driver: This one really pissed me off. It had me
> thinking apache2 AND my linksys router we're on the brink. For some
> unknown reason at least for me, in FF it would only half-load some
> pages, including ones on localhost AND my router (10.1.1.1) ... I
> dunno what the hell is up with this one. I have to stay with the
> syskonnect.com sk98lin patch, which.. doesn't work with 2.6.16 so I am
> back to 2.6.15 at the moment.
> 
> nVidia drivers: Broken. I posted a ftbfs bug on the debian bts, here
> is a current patch that works against the current release:
> http://bugs.debian.org/cgi-bin/bugreport.cgi/nvidia-kernel-source_1.0.8178-2.diff?bug=357992;msg=15;att=1

Luckily none of these are my fault.

> All in all, my experience sucked for the first time on this kernel.

/me does the "not my fault" look. 

> Good luck with this new one..

Heh. No new one in the works just yet, but I'm actually not planning on 
changing anything. Turn adaptive readahead off, and you're left with out of 
kernel tree, or worse, binary driver problems. 

Cheers,
Con


--=_mimegpg-kolivas.org-31285-1143114017-0004
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBEIokhZUg7+tp6mRURAlX6AJ9SLKoePAmn09FTZLwH6hR+swY7LgCfXR3N
9RYLWATB2vLkT5UUxNQ0cJ8=
=sMxC
-----END PGP SIGNATURE-----

--=_mimegpg-kolivas.org-31285-1143114017-0004--
