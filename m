Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289787AbSAWKkx>; Wed, 23 Jan 2002 05:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289775AbSAWKkn>; Wed, 23 Jan 2002 05:40:43 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:39815 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289685AbSAWKki>; Wed, 23 Jan 2002 05:40:38 -0500
Message-Id: <200201231040.g0NAeTKR009932@tigger.cs.uni-dortmund.de>
To: jan.ciger@epfl.ch
cc: Samuel Maftoul <maftoul@esrf.fr>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: umounting 
In-Reply-To: Message from Jan Ciger <jan.ciger@epfl.ch> 
   of "Wed, 23 Jan 2002 11:33:52 +0100." <m16TKj3-02103JC@ligsg2.epfl.ch> 
Date: Wed, 23 Jan 2002 11:40:29 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Ciger <jan.ciger@epfl.ch> said:
> > > So, the solution is - teach your users to unmount disks before leaving,
> > > or mount them in synchronous mode - but I am not sure, whether VFAT
> > > supports that and it is a performance hog too.
> >
> > Better use mtools. No mounting required, which does screw DOSish minds.
> 
> I agree, but it probably does work only with floppies. 

Nope. It obviosly needs access (R/W) to the device/partition, and the right
configuration. I've used it with floppies and parallel Zip drives, and
sometime even with a loopback-mounted floppy image ;-)
-- 
Horst von Brand			     http://counter.li.org # 22616
