Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSHRKAr>; Sun, 18 Aug 2002 06:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSHRKAr>; Sun, 18 Aug 2002 06:00:47 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:34764 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313113AbSHRKAq>;
	Sun, 18 Aug 2002 06:00:46 -0400
Date: Sun, 18 Aug 2002 12:03:03 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>, Larry McVoy <lm@bitmover.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE?
Message-ID: <20020818120303.A15416@ucw.cz>
References: <Pine.GSO.4.21.0208162057550.14493-100000@weyl.math.psu.edu> <Pine.LNX.4.44.0208161822130.1674-100000@home.transmeta.com> <20020817092239.A2211@flint.arm.linux.org.uk> <20020817235942.A11420@ucw.cz> <20020818015218.A20958@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020818015218.A20958@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Aug 18, 2002 at 01:52:18AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2002 at 01:52:18AM +0100, Russell King wrote:

> > We'll need PIO for control commands anyways, but the thing is that we
> > won't need to speed optimize PIO and will be able to kill multi-sector
> > PIO completely probably.
> 
> Well, I'll probably be maintaining multi-sector PIO externally to the
> main kernel in that case.  95% of ARM machines have either PIO only or
> in the case of those that do have PCI DMA support (netwinders) the
> southbridge is soo messed up that DMA is useless on most boxes produced.
> 
> Multi-sector PIO is a fundamental requirement that I require.

Good to know that.

-- 
Vojtech Pavlik
SuSE Labs
