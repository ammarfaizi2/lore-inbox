Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbSLOUnJ>; Sun, 15 Dec 2002 15:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbSLOUnJ>; Sun, 15 Dec 2002 15:43:09 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:1994 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262506AbSLOUnH>;
	Sun, 15 Dec 2002 15:43:07 -0500
Date: Sun, 15 Dec 2002 21:50:57 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: AnonimoVeneziano <voloterreno@tin.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE-CD and VT8235 issue!!!
Message-ID: <20021215215057.A12689@ucw.cz>
References: <3DFB7B21.7040004@tin.it> <200212142019.14449.black666@inode.at> <3DFBC4F3.2070603@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DFBC4F3.2070603@tin.it>; from voloterreno@tin.it on Sun, Dec 15, 2002 at 12:55:31AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2002 at 12:55:31AM +0100, AnonimoVeneziano wrote:
> Patrick Petermair wrote:
> 
> >Hi!
> >
> >Same problem here. I have addressed this issue several times...so far no 
> >solution.
> >
> >My specs:
> >MSI KT3 Ultra2 (VT8235)
> >TOSHIBA DVD-ROM SD-M1302
> >YAMAHA CRW8424E
> >
> >Kernel 2.4.19:
> >The one I'm currently using. It doesn't detect the VT8235 and therefore 
> >I have no dma. But I can access/mount my DVD without a problem.
> >
> >Kernel 2.4.20:
> >Detects the VT8235 at boot but hangs with my DVD Rom (hdc) --> doesn't 
> >boot. I have posted my problem here an Alan Cox suggested that I should 
> >try the -ac tree.
> >
> >Kernel 2.4.20-ac2:
> >Some improvements - It detects the VT8235 at boot, also my DVD and CDRW. 
> >It boots fine and I have DMA on all my discs. But as soon as I try to 
> >mount a CD/DVD (mount /cdrom) the system hangs and I get this:
 
> >
> Please, anyone help us, I can't live with a 6 MB HD bandwith!!!:-D

You're not alone with this problem. I suspect some fishy stuff in the
vt8235, because the driver programs it exactly the same as vt8233a, but
while the vt8233a doesn't seem to have problems with DVDs and CDs, the
vt8235 fails for many people.

It might be some new DVD drive, though.

Can you send me 'hdparm -i' of the drive?

I'll try to make a patch to circumvent the problem ...

Thanks.

-- 
Vojtech Pavlik
SuSE Labs
