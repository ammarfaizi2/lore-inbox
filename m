Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbUKDULA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbUKDULA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbUKDUH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:07:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:30219 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262434AbUKDUDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:03:38 -0500
Date: Thu, 4 Nov 2004 21:03:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ian Hastie <ianh@iahastie.clara.net>
Cc: Valdis.Kletnieks@vt.edu, Adam Heath <doogie@debian.org>,
       Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
Message-ID: <20041104200303.GO4013@stusta.de>
References: <41894779.10706@techsource.com> <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com> <200411041704.iA4H4sdZ014948@turing-police.cc.vt.edu> <200411041936.27100.ianh@iahastie.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411041936.27100.ianh@iahastie.local.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 07:36:26PM +0000, Ian Hastie wrote:
> On Thursday 04 Nov 2004 17:04, Valdis.Kletnieks@vt.edu wrote:
> > On Thu, 04 Nov 2004 10:50:38 CST, Adam Heath said:
> > > I didn't deny the speed difference of older and newer compilers.
> > >
> > > But why is this an issue when compiling a kernel?  How often do you
> > > compile your kernel?
> >
> > If you're working on older hardware (note the number of people on this
> > list still using 500mz Pentium3 and similar), and a kernel developer, the
> > difference between 2 hours to build a kernel and 4 hours to build a
> > kernel matters quite a bit.
> 
> How often is it necessary to do a full rebuild of the kernel?  If the 
> dependencies in the make system work properly then only the amended parts 
> should be recompiled.  That'd be a much bigger time saving than just using an 
> older compiler.

As soon as you touch include files, a full recompile occurs pretty 
often because there are some include files pretty every other file 
depends on (and has to depend on).

Well, although I'm doing full kernel compiles sometimes several times a 
day I'm not that much addicted to compiler speed but I do understand 
others are.

> Ian.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

