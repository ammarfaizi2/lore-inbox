Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267329AbRGPM3N>; Mon, 16 Jul 2001 08:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267333AbRGPM3D>; Mon, 16 Jul 2001 08:29:03 -0400
Received: from AMontpellier-201-1-2-148.abo.wanadoo.fr ([193.253.215.148]:19722
	"EHLO awak") by vger.kernel.org with ESMTP id <S267329AbRGPM2u>;
	Mon, 16 Jul 2001 08:28:50 -0400
Subject: Re: Linux 2.4.6-ac4
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <200107161158.NAA09324@harpo.it.uu.se>
In-Reply-To: <200107161158.NAA09324@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 16 Jul 2001 14:24:08 +0200
Message-Id: <995286249.28503.22.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it does not boot here.

I use 2.4.6-ac4, with the following hand-made patch in
drivers/pci/quirks.c:

-		if (rev < 0x40 && rev > 0x42)
+		if (rev < 0x40 || rev > 0x42)

It stops right after:
hdd: LG CD-RW CED-8080B, ATAPI CD/DVD-ROM drive

I have a VIA686b, lspci and all on demand.

Xav

