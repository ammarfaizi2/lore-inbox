Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbSLNAtI>; Fri, 13 Dec 2002 19:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265537AbSLNAtI>; Fri, 13 Dec 2002 19:49:08 -0500
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:44022 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S265523AbSLNAtG>; Fri, 13 Dec 2002 19:49:06 -0500
Date: Fri, 13 Dec 2002 17:49:37 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [BK fbdev] Yet again more fbdev updates.
In-Reply-To: <Pine.LNX.4.44.0212131611490.6750-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33.0212131745130.1882-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is UP, and not preemptible. And the backtrace may be corrupt, because
> when the page fault happens, it will actually page fault _again_ as part
> of trying to print out the oops, so the whole thing scrolls largely off
> the screen..

Thats right. If the low level console driver is broken it will call
printk which could be using the broken driver :-(

> I only see this on one of my laptops, and even there it seems to be
> timing-dependent or something (I think it only happens when I press a key,
> and because the backtrace isn't trustworthy ..)

If it happens only when you press a key which is always true:

1) Its the same place on the screen or a different place every time?

2) Always the last line of the screen?

3) Always the last column?


If you don't mind me asking what is model of your laptop to see if someone
else is having the same exact problem.

