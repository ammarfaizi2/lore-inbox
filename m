Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbTD2E1x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 00:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbTD2E1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 00:27:53 -0400
Received: from aktion1.adns.de ([62.116.145.13]:30665 "EHLO aktion1.adns.de")
	by vger.kernel.org with ESMTP id S261940AbTD2E1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 00:27:52 -0400
Message-ID: <3EAE0224.2030502@asbest-online.de>
Date: Tue, 29 Apr 2003 06:40:04 +0200
From: Sven Krohlas <sven@asbest-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4b) Gecko/20030423
X-Accept-Language: de, de-at, de-de, de-li, de-lu, de-ch, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc1 freezes
References: <fa.gkftieo.3iqshi@ifi.uio.no> <fa.ikvjpcr.34s8rv@ifi.uio.no>
In-Reply-To: <fa.ikvjpcr.34s8rv@ifi.uio.no>
X-Enigmail-Version: 0.74.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

>>Could you have a look at my boot.log and see if you've got
>>similar hardware? Maybe we can narrow the problem down a bit.
>
> 	I have VIA chipset too (KT400), I hope it is not chipset specific. Int=
> el, SIS
> people how are you doing?

Hey, don't forget my Ali one ;)
I see the problem with a Ali Aladdin V (ALI1543)

linux:/home/sven # lspci
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M1541 PCI to AGP Controller (rev 04)
00:02.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 03)
00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev c3)
00:09.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 26)
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:0c.0 Unknown mass storage controller: Promise Technology, Inc. 20269 (rev 02)
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1)
01:00.0 VGA compatible controller: nVidia Corporation NV4 [Riva TnT] (rev 04)

BTW: At least DMA is working for me again with rc1 on my M1541 :-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+rgIiUKRT/HXmN7cRAplyAKDjW3VJU3f1hgHdOluiBEATfys3PQCg1xcr
+S5tDsirlzpaJ9qhNmXIVGA=
=U8lZ
-----END PGP SIGNATURE-----

