Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266827AbUGLN1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266827AbUGLN1S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 09:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266828AbUGLN1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 09:27:17 -0400
Received: from mail.eris.qinetiq.com ([128.98.1.1]:14892 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S266820AbUGLN0e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 09:26:34 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: Re: HDIO_SET_DMA failed on a Dell Latitude C400 Laptop
Date: Mon, 12 Jul 2004 14:22:00 +0100
User-Agent: KMail/1.6.1
References: <200407121407.14428.m.watts@eris.qinetiq.com>
In-Reply-To: <200407121407.14428.m.watts@eris.qinetiq.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407121422.00841.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> I've just burnt a cd for the first time on a Dell Latitude C400 laptop and
> I noticed that the system was quite sluggish while the burn was happening.
> (mouse pointer erratic, window redraw slow etc).
>
> Remembering a similar issue with a desktop system, I did the following to
> enable DMA on the hard drive (hdparm was giving ~3MB/sec read)
>
> # hdparm -c1 -d1 /dev/hda
>
> /dev/hda
>  setting 32-bit IO_support flag to 1
>  setting using_dma to 1 (on)
>  HDIO_SET_DMA failed: Operation not permitted
>  IO_support   =  1 (32-bit)
>  using_dma   =  0 (off)
>
>
> hdparm now reports ~7MB/sec which is better but still prety poor.
>
>
> Any ideas why I couldn't set DMA on the drive?
>
>
> CPU = Mobile Pentum 3 @1.2GHz (800MHz when booted with no power cord)
> Ram = 256MB
> HDD = IBM Travelstar (IC25N020ATDA04-0) 20GB
> BIOS Rev = A12

Kernel is a 2.6.7 kernel...

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA8pB4Bn4EFUVUIO0RAjmoAJ93XBQpvOhfi3PNWvNDIHDvT6WASQCcDmlI
TI0LXhd4IxLKE6sMK3W7mls=
=rzX2
-----END PGP SIGNATURE-----
