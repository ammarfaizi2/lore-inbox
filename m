Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269046AbUJKOaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269046AbUJKOaR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269032AbUJKO3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:29:47 -0400
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:27100 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S269014AbUJKOXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:23:17 -0400
Message-ID: <416A9746.8090506@kolivas.org>
Date: Tue, 12 Oct 2004 00:23:02 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc4-mm1
References: <20041011032502.299dc88d.akpm@osdl.org>	 <416A7CC8.6040500@kolivas.org> <1097500655.31264.15.camel@localhost.localdomain>
In-Reply-To: <1097500655.31264.15.camel@localhost.localdomain>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2F03EC9125747F3DD9DAADF1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2F03EC9125747F3DD9DAADF1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> On Llu, 2004-10-11 at 13:30, Con Kolivas wrote:
> 
>>Andrew Morton wrote:
>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/
>>
>>I have a keyboard problem from 2 things that seem related:
>>
>>mm1 dmesg:
>>---
>>ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
>>i8042.c: Can't read CTR while initializing i8042.
> 
> 
> Intel E7xxx board ? If so you either need the patch I posted ages ago
> (or grab it from a Fedora kernel) or to turn off USB legacy in the BIOS.

No. ASUS P4P800. USB legacy is off in the BIOS. This is a new bug as of 
recent mms.

00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host 
Bridge (rev 02)
00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP 
Bridge (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corp. 82801DB LPC Interface Controller (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801DB Ultra ATA Storage Controller 
(rev 02)
00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio 
Controller (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 
440 AGP 8x] (rev a4)
02:05.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
02:0d.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
02:0d.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)

Con

--------------enig2F03EC9125747F3DD9DAADF1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBapdJZUg7+tp6mRURAsU+AJsGRvvq0/5WDEfxoJkKaqNV3BuZygCfftIK
mZFfTpXxpdYEswg24sGWkBk=
=fSLW
-----END PGP SIGNATURE-----

--------------enig2F03EC9125747F3DD9DAADF1--
