Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286737AbRLVJEA>; Sat, 22 Dec 2001 04:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286736AbRLVJDv>; Sat, 22 Dec 2001 04:03:51 -0500
Received: from d-dialin-1587.addcom.de ([62.96.165.155]:50927 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S286735AbRLVJDg>; Sat, 22 Dec 2001 04:03:36 -0500
Date: Sat, 22 Dec 2001 10:03:47 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Renaud Guerin <rguerin@free.fr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PCI IRQ routing on VIA82C686 (+ACPI)
In-Reply-To: <1008994554.3c2408fa0ad36@imp.free.fr>
Message-ID: <Pine.LNX.4.33.0112220958190.1352-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2001, Renaud Guerin wrote:

> I'm having trouble with the PCI IRQ setup code on a Medion 9626 laptop (K7 
> with VIA82C686 aka Apollo Super), both with the standard code and with the 
> ACPI-based pci-irq.c patch from Kai (although the latter seems to get 
> further).

Could you please supply the following information:

dmesg from a kernel with / w/o my patch, but with #define DEBUG in
arch/i386/kernel/pci-i386.h.

lspci -vxxx -s 07.0 in the various working / non-working cases.

>  10:          1          XT-PIC  eth0

> [root@tux root]# ping -d -c 5 192.168.1.1

>  10:          2          XT-PIC  eth0

Is that supposed to be the working case? 1 interrupt seems a bit too 
few.

--Kai


