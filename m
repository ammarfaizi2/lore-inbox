Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319842AbSHRAsZ>; Sat, 17 Aug 2002 20:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319844AbSHRAsY>; Sat, 17 Aug 2002 20:48:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44551 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319840AbSHRAsX>; Sat, 17 Aug 2002 20:48:23 -0400
Date: Sun, 18 Aug 2002 01:52:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>, Larry McVoy <lm@bitmover.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE?
Message-ID: <20020818015218.A20958@flint.arm.linux.org.uk>
References: <Pine.GSO.4.21.0208162057550.14493-100000@weyl.math.psu.edu> <Pine.LNX.4.44.0208161822130.1674-100000@home.transmeta.com> <20020817092239.A2211@flint.arm.linux.org.uk> <20020817235942.A11420@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020817235942.A11420@ucw.cz>; from vojtech@suse.cz on Sat, Aug 17, 2002 at 11:59:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 11:59:42PM +0200, Vojtech Pavlik wrote:
> We'll need PIO for control commands anyways, but the thing is that we
> won't need to speed optimize PIO and will be able to kill multi-sector
> PIO completely probably.

Well, I'll probably be maintaining multi-sector PIO externally to the
main kernel in that case.  95% of ARM machines have either PIO only or
in the case of those that do have PCI DMA support (netwinders) the
southbridge is soo messed up that DMA is useless on most boxes produced.

Multi-sector PIO is a fundamental requirement that I require.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

