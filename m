Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132548AbRALTvc>; Fri, 12 Jan 2001 14:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132138AbRALTvW>; Fri, 12 Jan 2001 14:51:22 -0500
Received: from styx.suse.cz ([195.70.145.226]:35314 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S132548AbRALTvH>;
	Fri, 12 Jan 2001 14:51:07 -0500
Date: Fri, 12 Jan 2001 20:51:05 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Laberge <mlsoft@videotron.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Tobias Ringstrom <tori@tellus.mine.nu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 ate my filesystem on rw-mount
Message-ID: <20010112205105.C2740@suse.cz>
In-Reply-To: <E14H1Ls-00047Z-00@the-village.bc.nu> <3A5F3D89.5DED9C80@videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5F3D89.5DED9C80@videotron.ca>; from mlsoft@videotron.ca on Fri, Jan 12, 2001 at 12:23:21PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 12:23:21PM -0500, Martin Laberge wrote:

> > > This is on a 450 MHz AMD-K6 with the following IDE controller:
> > > 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
> >
> > There are several people who have reported that the 2.4.0 VIA IDE driver
> > trashes hard disks like that. The 2.2 one also did this sometimes but only
> > with specific chipset versions and if you have dma autotune on (thats why
> > currently 2.2 refuses to do tuning on VP3)
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> 
> I had exactly the same problem with my K6-350 and IDE VT82C586a
> on a kernet 2.2.16    ..... i just made a hdparm to enable DMA and pooffff....
> lost all data .... reinstall necessary from scratch

Is this problem still present with 2.4.0? Well, you don't need to kill
your data to test this - make sure the kernel is mounting the
filesystems read only in the test. DMA will be probably enabled
automatically for your drives.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
