Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161233AbWALUGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161233AbWALUGR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161234AbWALUGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:06:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21874 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1161233AbWALUGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:06:16 -0500
Date: Thu, 12 Jan 2006 21:08:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
       "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-$SHA1: VT <-> X sometimes odd
Message-ID: <20060112200803.GB3945@suse.de>
References: <20060110162305.GA7886@mipter.zuzino.mipt.ru> <43C4F114.9070308@gmail.com> <20060111153822.GA7879@mipter.zuzino.mipt.ru> <20060112192856.GA7938@mipter.zuzino.mipt.ru> <Pine.LNX.4.64.0601121119100.3535@g5.osdl.org> <Pine.LNX.4.64.0601121201520.3535@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601121201520.3535@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12 2006, Linus Torvalds wrote:
> 
> 
> On Thu, 12 Jan 2006, Linus Torvalds wrote:
> >
> > or if that isn't it, and you have an IDE drive, can you try if the 
> > appended trivial patch makes a difference?
> 
> I just pushed out a commit that reverts the IDE softirq request 
> completion, so if you pull a recent enough git tree, and you see that 
> revert (by Jens), the patch in the previous email won't apply, but it 
> won't be needed either.

Yes thanks for applying it Linus, felt like the best move right now. I'd
rather work on this later and get a stabler -rc1 out the door sooner.

-- 
Jens Axboe

