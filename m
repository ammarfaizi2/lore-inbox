Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266839AbSLPK1R>; Mon, 16 Dec 2002 05:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266840AbSLPK1R>; Mon, 16 Dec 2002 05:27:17 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:7138 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S266839AbSLPK1Q>;
	Mon, 16 Dec 2002 05:27:16 -0500
Date: Mon, 16 Dec 2002 11:34:58 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Patrick Petermair <black666@inode.at>,
       AnonimoVeneziano <voloterreno@tin.it>,
       Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: IDE-CD and VT8235 issue!!!
Message-ID: <20021216113458.A31837@ucw.cz>
References: <3DFB7B21.7040004@tin.it> <3DFBC4F3.2070603@tin.it> <20021215215057.A12689@ucw.cz> <200212152256.25266.black666@inode.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200212152256.25266.black666@inode.at>; from black666@inode.at on Sun, Dec 15, 2002 at 10:56:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2002 at 10:56:25PM +0100, Patrick Petermair wrote:
> Vojtech Pavlik:
> 
> > You're not alone with this problem. I suspect some fishy stuff in the
> > vt8235, because the driver programs it exactly the same as vt8233a,
> > but while the vt8233a doesn't seem to have problems with DVDs and
> > CDs, the vt8235 fails for many people.
> 
> Thanks for the info ... like I expected ...
> 
> > Can you send me 'hdparm -i' of the drive?
> 
> starbase:/# hdparm -i /dev/hdc
> 
> /dev/hdc:
> 
>  Model=TOSHIBA DVD-ROM SD-M1302, FwRev=1006, SerialNo=X900304741
>  Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
>  RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
>  BuffType=unknown, BuffSize=256kB, MaxMultSect=0
>  (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4 
>  DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 
>  UDMA modes: udma0 udma1 *udma2 
>  AdvancedPM=no
> 
> Thanks for all your effort here. It's great to see such a good 
> community.

If you can, please try 2.4.20 with this patch.

-- 
Vojtech Pavlik
SuSE Labs
