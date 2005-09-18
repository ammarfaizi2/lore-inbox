Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbVIRSAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVIRSAu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 14:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVIRSAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 14:00:50 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:16644 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932145AbVIRSAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 14:00:50 -0400
Date: Sun, 18 Sep 2005 20:00:27 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Denis Vlasenko <vda@ilport.com.ua>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: p = kmalloc(sizeof(*p), )
Message-ID: <20050918180027.GB595@alpha.home.local>
References: <20050918100627.GA16007@flint.arm.linux.org.uk> <1127041474.8932.4.camel@localhost.localdomain> <20050918143907.GK19626@ftp.linux.org.uk> <200509181925.25112.vda@ilport.com.ua> <20050918173058.GM19626@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050918173058.GM19626@ftp.linux.org.uk>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 06:30:58PM +0100, Al Viro wrote:
> On Sun, Sep 18, 2005 at 07:25:24PM +0300, Denis Vlasenko wrote:
> > Do these qualify?
> > 
> > http://www.uwsg.iu.edu/hypermail/linux/kernel/0105.1/0579.html
> > o Fix wrong kmalloc sizes in ixj/emu10k1 (David Chan) 
> 
> ixj does, emu10k does not (sizeof(p) instead of sizeof(*p) would be
> exact same bug).

Funny, a few days ago, I found such a bug in a coworker's code. I agree
that finding this at 3am would be close to impossible. OK, you converted
me :-)

Regards,
Willy

