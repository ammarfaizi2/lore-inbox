Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267273AbUBMWtz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 17:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267271AbUBMWty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 17:49:54 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:2830 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S267304AbUBMWr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 17:47:58 -0500
Date: Fri, 13 Feb 2004 23:45:24 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File system performance, hardware performance, ext3, 3ware RAID1, etc.
Message-ID: <20040213224524.GB13937@alpha.home.local>
References: <402C0D0F.6090203@techsource.com> <20040213055350.GG29363@alpha.home.local> <20040213193046.GA17790@bounceswoosh.org> <Pine.LNX.4.58.0402131146040.2144@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402131146040.2144@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 11:55:16AM -0800, Linus Torvalds wrote:
 
> > the absolute worst-case write performance should be the same as read
> > performance.
> 
> That is only true if the disk block-size is smaller than the IO blocksize. 
> Can somebody fill me in on what modern disks do, especially the 
> high-density ones?

This is purely hypothetical, but perhaps write-precompensation or the signal
intensity or shape in the head implies to write at "safer" frequencies ? we're
speaking about hundreds of megahertz, and I've always wondered what the signal
looks like when it reaches the head.

Cheers,
Willy

