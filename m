Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319449AbSIGHnM>; Sat, 7 Sep 2002 03:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319451AbSIGHnM>; Sat, 7 Sep 2002 03:43:12 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:11273
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319449AbSIGHnL>; Sat, 7 Sep 2002 03:43:11 -0400
Date: Sat, 7 Sep 2002 00:46:53 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Eli <eli@pflash.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: IO errors: SanDisk ImageMate USB CF, SD, MMC reader
In-Reply-To: <E17nXKB-0004DB-00@albatross.prod.itd.earthlink.net>
Message-ID: <Pine.LNX.4.10.10209070045030.11256-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Because SD is DRM and since the method to double pump a split read/write10
across the bus is not very simple nor public, there is legal problem.
I suspect I just got myself one for even mentioning the stuff above.

On Fri, 6 Sep 2002, Eli wrote:

> All,
> 
> Problem Summary:
> I have a SanDisk ImageMate USB compactFlash + SecureDigital + MultiMediaCard 
> reader, and I am getting IO errors trying to read a 128MB SimpleTech CF card 
> with 2.4 kernels.
> 
> Details:
> 
> I have an 8MB Canon CF card and a 128MB SimpleTech CF card.
> 
> With the USB reader, I see:
> OS or Device      | 8MB | 128MB |
> ------------------+-----+-------+
> MacOS 9           |  OK |   OK  |
> RH 2.4.17-0.16smp |  OK |  ERR  |
> RH 2.4.18-3       |  OK |  ERR  |
> 
> ERR means that I get IO errors when I try to 'cp -a' the contents of the CF 
> card to local disk.
> "pc: reading '/mnt/flash1.....': Input/output error" is repeated for many of 
> the files on the card, but not all of them.  Most of them seem to be later 
> files.
> 
> Also, with a PCMCIA adapter in the RH 2.4.18-3, both CF cards work.
> Both cards also work in a HandEra 300 PDA and a Canon PowerShot A40 digital 
> camera.
> 
> Any suggestions of how I could track down the problem?  (I've submitted a bug 
> report to SanDisk as well, but this looks like a Linux problem to me.)
> 
> (Please CC me as I am not subscribed here at home.)
> 
> Eli Carter
> retracile(a)earthlink.net
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

