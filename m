Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293138AbSBWNo3>; Sat, 23 Feb 2002 08:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293139AbSBWNoT>; Sat, 23 Feb 2002 08:44:19 -0500
Received: from 34dyn21.com21.casema.net ([212.64.15.21]:56520 "HELO
	fruit.eu.org") by vger.kernel.org with SMTP id <S293138AbSBWNoF>;
	Sat, 23 Feb 2002 08:44:05 -0500
Date: Sat, 23 Feb 2002 14:44:01 +0100
From: Wessel Dankers <wsl@fruit.eu.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HPT366: DMA errors?
Message-ID: <20020223144400.D22191@fruit.eu.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0202212304240.438-100000@sartre.linuxbr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0202212304240.438-100000@sartre.linuxbr.com>; from sartre@linuxbr.com on Thu, Feb 21, 2002 at 11:14:11PM -0300
X-oi: oi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-02-21 23:14:11-0300, Cesar Suga wrote:
> 	Hello, all.
> 
> 	I am using an ABIT BP6 board (SMP, 2 Celerons at 366MHz, none
> overclocked, *very* stable) which uses the HPT366 controller. I am getting
> through these messages when using the *original* ATA cable (never touched
> before) or a replacement one:
> 
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x84 { DriveStatusError BadCRC }

I got this very same error on my normal VIA ide controller with every cable
I tried until I figured out that perhaps I should like, actually compile in
the VIA driver :)

Basically, reading would go without problems but writing would give the
above error and make the controller go back to PIO mode access. I agree
that it is most likely a cable problem but I wouldn't rule out the driver a
priori.

--
Wessel Dankers <wsl@fruit.eu.org>

Small animal kamikaze attack on power supplies
