Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288581AbSADK1X>; Fri, 4 Jan 2002 05:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288583AbSADK1N>; Fri, 4 Jan 2002 05:27:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43279 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288581AbSADK06>; Fri, 4 Jan 2002 05:26:58 -0500
Subject: Re: Who uses hdx=bswap or hdx=swapdata?
To: Geert.Uytterhoeven@sonycom.com (Geert Uytterhoeven)
Date: Fri, 4 Jan 2002 10:37:47 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        manfred@colorfullife.com (Manfred Spraul),
        linux-kernel@vger.kernel.org (Linux Kernel Development),
        linux-m68k@lists.linux-m68k.org (Linux/m68k)
In-Reply-To: <Pine.GSO.4.21.0201041009000.12102-100000@vervain.sonytel.be> from "Geert Uytterhoeven" at Jan 04, 2002 10:09:46 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16MRjQ-0003Sb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IIRC it's used to access non-Atari IDE disks on Atari (which has a byte-swapped
> IDE interface) and vice-versa.
> 
> So yes, you can use it on SMP machines, to access disks that were used before
> on Atari.

For 2.5 would it perhaps be cleaner if we had a bswapping loop device. Sort
of very bad crypto mode ?
