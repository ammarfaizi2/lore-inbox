Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270897AbTGPOzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270898AbTGPOzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:55:19 -0400
Received: from mail.eris.qinetiq.com ([128.98.1.1]:23076 "HELO
	ns0.eris.dera.gov.uk") by vger.kernel.org with SMTP id S270897AbTGPOym
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:54:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: Re: VESA Framebuffer dead in 2.6.0-test1
Date: Wed, 16 Jul 2003 16:08:34 +0100
User-Agent: KMail/1.4.3
References: <200307161406.h6GE6iHt002041@sirius.nix.badanka.com>
In-Reply-To: <200307161406.h6GE6iHt002041@sirius.nix.badanka.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307161608.34637.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Hi.
>
> A number of people have experienced the same problem as I have; the VESA
> framebuffer is just..black on boot. I haven't seen any reports on this,
> though. dmesg says what it always have said before about the fb.
>
> I boot with vga=791 (as specified in lilo.conf).. Have something changed
> or is it just broken? :o)
>
> Thanks.

I boot with vga=0x343 (1400x1050) and its working fine (2.6.0-test1)

This is a Dell Latitude C610 laptop, so it may be using the ati framebuffer 
stuff, although I get this in dmesg:

vesafb: framebuffer at 0xe0000000, mapped to 0xd8800000, size 16384k
vesafb: mode is 1400x1050x24, linelength=4200, pages=2
vesafb: protected mode interface info at c000:5378
vesafb: scrolling: redraw
vesafb: directcolor: size=0:8:8:8, shift=0:16:8:0
fb0: VESA VGA frame buffer device
Console: switching to colour frame buffer device 175x65

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/FWpyBn4EFUVUIO0RAjqwAJ43U2vmUw7kMFkoeIsdDLyxhAbLBQCgmMST
LO8Pk8CAhCD0Uq/kuPd9hBo=
=W+2A
-----END PGP SIGNATURE-----

