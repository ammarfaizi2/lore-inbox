Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287490AbSAHUFD>; Tue, 8 Jan 2002 15:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287571AbSAHUEx>; Tue, 8 Jan 2002 15:04:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287490AbSAHUEm>; Tue, 8 Jan 2002 15:04:42 -0500
Subject: Re: PROBLEM: "shutdown -r now" (lilo, win98) (fwd)
To: rhw@MemAlpha.cx
Date: Tue, 8 Jan 2002 20:15:07 +0000 (GMT)
Cc: st.mase@web.de (Stepan Maseizik),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.21.0201081952090.7547-100000@Consulate.UFP.CX> from "Riley Williams" at Jan 08, 2002 07:55:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16O2eJ-0007VZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>                 bootloader) the computer hangs a few seconds after the initial
>                 win98 start-picture.  Horizontal white lines run across the
>                 screen, the win98 startlogo is still visible.
>                 A "shutdown -r now" rebooting linux works just fine!
>                 A "shutdown -h now", restrating the computer and selcting
>                 win98 from the lilo-menu works fine as well!

Some windows driver is assuming things that the BIOS has not cleared up
on reset and whichit probably shouldn't. Its not uncommon to have to 
powercycle a box between OS's. Sometimes you see it with windows hanging
sometimes with Linux
