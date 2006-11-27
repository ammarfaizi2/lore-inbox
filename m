Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755620AbWK0AlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620AbWK0AlY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 19:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755622AbWK0AlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 19:41:24 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:19986 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1755604AbWK0AlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 19:41:23 -0500
Date: Mon, 27 Nov 2006 00:41:13 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kyle McMartin <kyle@parisc-linux.org>, Ralf Baechle <ralf@linux-mips.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: Build breakage ...
Message-ID: <20061127004112.GD30767@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kyle McMartin <kyle@parisc-linux.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>
References: <20061126224928.GA22285@linux-mips.org> <Pine.LNX.4.64.0611261459010.3483@woody.osdl.org> <Pine.LNX.4.64.0611261509330.3483@woody.osdl.org> <20061126232128.GC30767@flint.arm.linux.org.uk> <Pine.LNX.4.64.0611261627260.30076@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611261627260.30076@woody.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2006 at 04:29:00PM -0800, Linus Torvalds wrote:
> On Sun, 26 Nov 2006, Russell King wrote:
> > > 
> > > Ralf, Russell, does this work for you guys?
> > 
> > Not at all.  It creates even more problems for me, with this circular
> > dependency:
> 
> Ok. I just reverted it then. 
> 
> Pls verify that this is all good, and I didn't mess anything up due to the 
> manual conflict resolution.

That fixes the ARM assabet build, which should mean the other ARM builds
are also fixed.  Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
