Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136278AbRDVTx0>; Sun, 22 Apr 2001 15:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136279AbRDVTxR>; Sun, 22 Apr 2001 15:53:17 -0400
Received: from [209.250.60.85] ([209.250.60.85]:29200 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S136278AbRDVTxB>; Sun, 22 Apr 2001 15:53:01 -0400
Date: Sun, 22 Apr 2001 14:52:20 -0500
From: Steven Walter <srwalter@yahoo.com>
To: andersg@0x63.nu
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide dma in /proc/dma
Message-ID: <20010422145220.A7257@hapablap.dyn.dhs.org>
In-Reply-To: <20010422135359.A21013@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010422135359.A21013@h55p111.delphi.afb.lu.se>; from andersg@0x63.nu on Sun, Apr 22, 2001 at 01:53:59PM +0200
X-Uptime: 2:42pm  up 2 days, 23:36,  1 user,  load average: 1.16, 1.06, 1.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2001 at 01:53:59PM +0200, andersg@0x63.nu wrote:
> Hi!
> 
> why doesnt the dma for ide disks show up in /proc/dma?
> 
> heineken:~# hdparm -d /dev/discs/disc0/disc 
> /dev/discs/disc0/disc:
>  using_dma    =  1 (on)
> 
> heineken:~# cat /proc/dma 
>  4: cascade

I suspect this is because only ISA DMA's are listed in /proc/dma, and
your IDE controller is likely PCI.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
