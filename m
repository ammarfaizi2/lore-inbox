Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267647AbUG3IS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267647AbUG3IS1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 04:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267653AbUG3IS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 04:18:27 -0400
Received: from mailr.eris.qinetiq.com ([128.98.1.9]:11213 "HELO
	qinetiq-tim.net") by vger.kernel.org with SMTP id S267647AbUG3ISY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 04:18:24 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Andrew Morton <akpm@osdl.org>
Subject: Re: mke2fs -j goes nuts on 3Ware 8506-4LP
Date: Fri, 30 Jul 2004 09:21:43 +0100
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <200407281050.24958.m.watts@eris.qinetiq.com> <20040728225146.69748f52.akpm@osdl.org>
In-Reply-To: <20040728225146.69748f52.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407300921.47184.m.watts@eris.qinetiq.com>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.26.0.10; VDF: 6.26.0.51; host: mailr.qinetiq-tim.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Mark Watts <m.watts@eris.qinetiq.com> wrote:
> > I have a 3Ware 8506-4LP controller with 4 250GB Maxtor SATA drives, in a
> >  raid-5 configuration (64K blocks)
> >  System is:
> >  Dual Opteron 246 (2GHz)
> >  2GB RAM
> >  Tyan S2875 motherboard
> >
> >  Kernel: 2.6.8-rc2 (pre-empt is ON)
> >  Rest of OS: Mandrake 10.0 AMD64 edition.
> >
> >  When I execute a mke2fs -j /dev/sda7  to format a 600GB partition on the
> > raid as ext3, the system slows to a crawl.
>
> It's conceivably a memory reclaim problem.  Please try booting with the
> boot command line option `mem=768M', then see if it goes any better.

No change at all, apart from the slowdown happening quicker.

I reverted to 2.6.8rc1 without pre-empt and that didnt help either.

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBCgUbBn4EFUVUIO0RAkHSAJ0YogN0UuxNY7680W8foDM993mJRQCeMVAY
kQeNvt6WHSiFWJ6J0f97g5g=
=0UVo
-----END PGP SIGNATURE-----
