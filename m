Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267779AbRGQGpa>; Tue, 17 Jul 2001 02:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267780AbRGQGpU>; Tue, 17 Jul 2001 02:45:20 -0400
Received: from astcc-232.astound.net ([24.219.123.215]:47620 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267779AbRGQGpO>; Tue, 17 Jul 2001 02:45:14 -0400
Date: Mon, 16 Jul 2001 23:45:26 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Zygo Blaxell <zblaxell@feedme.hungrycats.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Promise FastTrack 100 TX2 PCI device ID's
In-Reply-To: <E15MMMs-0007nj-00@sana.furryterror.org>
Message-ID: <Pine.LNX.4.10.10107162342210.3343-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That is a differnet beast.
Did it work if so how well?

Send 'lspci -bxxxzz > 20268.fttk.pci'  just for kicks.

Cheers,

On Tue, 17 Jul 2001, Zygo Blaxell wrote:

> I recently installed a shiny new Promise FastTrack 100 TX2.  'lspci -n'
> shows this (among other things):
> 
> 	00:0a.0 RAID bus controller: Promise Technology, Inc.: Unknown device 6268 (rev 01)
> 
> The latest IDE patches (2.4.6) on top of Linux 2.4.6 I can find say this:
> 
> 	#define PCI_DEVICE_ID_PROMISE_20268     0x4d68
> 
> Needless to say, the kernel fails to see my Promise card.
> 
> If I change the #define to
> 
> 	#define PCI_DEVICE_ID_PROMISE_20268     0x6268
> 
> everything seems to work:  the Promise card is detected and seems to function.
> 
> Am I missing something, or is there another kind of "Promise FastTrack
> 100 TX2" floating around?
> -- 
> Zygo Blaxell (Laptop) <zblaxell@feedme.hungrycats.org>
> GPG = D13D 6651 F446 9787 600B AD1E CCF3 6F93 2823 44AD
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

