Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266406AbSL2BJV>; Sat, 28 Dec 2002 20:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266407AbSL2BJV>; Sat, 28 Dec 2002 20:09:21 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:39431 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266406AbSL2BJU>; Sat, 28 Dec 2002 20:09:20 -0500
Date: Sun, 29 Dec 2002 01:16:25 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Richard Henderson <rth@twiddle.net>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [FB PATCH] cfbimgblt isn't 64-bit clean
In-Reply-To: <20021227151843.A3108@twiddle.net>
Message-ID: <Pine.LNX.4.44.0212290027590.14098-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The text is written as if it's thinking about handling 64-bit
> unsigned long, but it doesn't.  The tables that map bits to
> pixels are completely unprepared for this.
> 
> I thought about widening the tables, but I thought they'd get
> unreasonably large.  There's no reason not to go ahead and 
> handle this 32-bits at a time.

I thought the tables would come back to haunt us. The only reason the 
tables where introduced was for speed enhancements. I reason the code is 
extra complex was so you could pass 64 bits of data across the bus. I 
still like to see that happen still. What do you think?





