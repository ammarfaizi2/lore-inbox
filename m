Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263791AbTKXPq6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 10:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTKXPqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 10:46:05 -0500
Received: from mout1.freenet.de ([194.97.50.132]:59883 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S263786AbTKXPpK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 10:45:10 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [2.6.0-test10] standby freezes bttv
Date: Mon, 24 Nov 2003 16:44:56 +0100
User-Agent: KMail/1.5.93
References: <200311241420.08216.mbuesch@freenet.de> <20031124134212.GE30618@bytesex.org>
In-Reply-To: <20031124134212.GE30618@bytesex.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200311241645.05926.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 24 November 2003 14:42, Gerd Knorr wrote:
> > Nov 24 14:10:29 lfs kernel: bttv0: timeout: risc=1fd6601c, bits: VSYNC
> > HSYNC OFLOW HLOCK VPRES RISCI Nov 24 14:10:29 lfs kernel: bttv0: reset,
> > reinitialize
>
> Does that still happen with the updates from bytesex.org/patches?

I tried to apply
20_v4l2-2.6.0-test8.diff
30_tuner-2.6.0-test8.diff
30_btaudio-2.6.0-test8.diff
30_bttv-0.9.x-2.6.0-test8.diff
30_i2c-2.6.0-test8.diff

bttv-patch didn't apply cleanly, but I applied
it manually. Compiling gave these errors (as expected (tm) )

In file included from drivers/media/video/bttv-driver.c:39:
drivers/media/video/bttvp.h:44:29: media/ir-common.h: No such file or directory
In file included from drivers/media/video/bttv-driver.c:39:
drivers/media/video/bttvp.h:267: error: field `ir' has incomplete type

As I'm using test-10, do you have updated patches?

>   Gerd

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD4DBQE/wieAoxoigfggmSgRApAsAJ438vX2VFv02BomxGwknh8mrA/OmgCY4SK/
c/9w3EO6YfWh1rGNwkNwag==
=Vb55
-----END PGP SIGNATURE-----
