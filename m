Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318097AbSHQSYZ>; Sat, 17 Aug 2002 14:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318113AbSHQSYY>; Sat, 17 Aug 2002 14:24:24 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:39185
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318097AbSHQSYR>; Sat, 17 Aug 2002 14:24:17 -0400
Date: Sat, 17 Aug 2002 11:18:28 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE?
In-Reply-To: <20020817181624.GM10730@lug-owl.de>
Message-ID: <Pine.LNX.4.10.10208171115420.23171-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One of the issues I am addressing is how to deal w/ VDMA or PIO over
PCI-DMA or FP-DMA issues.  First Party DMA is how things will get done,
and regardless there will still be an need for PIO.

As long as ther transport layer requires it regardless of the wrapper or
pipe it is run down, it shall be around.

Regards,

Andre Hedrick
LAD Storage Consulting Group


On Sat, 17 Aug 2002, Jan-Benedict Glaw wrote:

> On Fri, 2002-08-16 18:35:29 -0700, Linus Torvalds <torvalds@transmeta.com>
> wrote in message <Pine.LNX.4.44.0208161822130.1674-100000@home.transmeta.com>:
> > On Fri, 16 Aug 2002, Alexander Viro wrote:
> 
> >     - in particular, it would only bother with PCI (or better) 
> >       controllers, and with UDMA-only setups.
> [...]
> > And then in five years, in Linux-3.2, we might finally just drop support 
> > for the old IDE code with PIO etc. Inevitably some people will still use 
> 
> That's bad. Then, you're nailed to use old kernels without having
> possibilities of recent kernels only because you're working with eg. old
> Alphas, PCMCIA-IDE things or so? Bad, bad, badhorribly bad. Even it's
> sloooow, there'll always some need for PIO-only controller support...
> 
> MfG, JBG
> 
> -- 
> Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
> 	 -- New APT-Proxy written in shell script --
> 	   http://lug-owl.de/~jbglaw/software/ap2/
> 

