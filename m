Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314559AbSESQYo>; Sun, 19 May 2002 12:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314583AbSESQYn>; Sun, 19 May 2002 12:24:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2318 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314559AbSESQYm>; Sun, 19 May 2002 12:24:42 -0400
Subject: Re: nVidia NIC/IDE/something support?
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Sun, 19 May 2002 17:00:24 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200205191514.g4JFEsV13608@mail.pronto.tv> from "Roy Sigurd Karlsbakk" at May 19, 2002 05:14:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E179T6e-0003x5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just bought this Asus board, A7N266-VM, with nVidia IDE, LAN and god knows 
> chipset. Linux doesn't understand it, and I really want it... Any plans of 
> supporting this? See below for /proc/pci output.

Depends if Nvidia want to be helpful. The audio is now supported (someone
was able to deduce that it was a clone of the intel one). For the ethernet
you might want to try random things that expect that much mmio and I/O 
space until you find what they licensed if its not their own

>   Bus  0, device   5, function  0:
>     Multimedia audio controller: PCI device 10de:01b0 (nVidia Corporation) 
> (rev 194).

This one I've not seen before

>   Bus  0, device   6, function  0:
>     Multimedia audio controller: PCI device 10de:01b1 (nVidia Corporation) 

But this is supported. I wonder if both are the same ?

Alan
