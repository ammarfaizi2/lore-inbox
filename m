Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbTLaBBP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 20:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265788AbTLaBBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 20:01:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:24245 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263518AbTLaBBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 20:01:13 -0500
Date: Tue, 30 Dec 2003 17:01:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Molina <tmolina@cablespeed.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
In-Reply-To: <Pine.LNX.4.58.0312301938060.3193@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0312301658580.2065@home.osdl.org>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
 <Pine.LNX.4.58.0312291420370.1586@home.osdl.org>
 <Pine.LNX.4.58.0312291755080.5835@localhost.localdomain>
 <Pine.LNX.4.58.0312291502210.1586@home.osdl.org>
 <Pine.LNX.4.58.0312300903170.2825@localhost.localdomain>
 <20031230143929.GN27687@holomorphy.com> <Pine.LNX.4.58.0312301524220.3152@localhost.localdomain>
 <Pine.LNX.4.58.0312301318540.2065@home.osdl.org>
 <Pine.LNX.4.58.0312301938060.3193@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Dec 2003, Thomas Molina wrote:
> 
> So you are telling me that I am paying the price for running development 
> kernels and enabling all the debugging.  I enjoy running the development 
> stuff and testing new stuff.  I enabled all the kernel hacking and 
> debugging options with the idea it might be useful for testing purposes.  

It's very useful, but some of the debugging options are literally _very_ 
intrusive, and can change usage patterns a lot.

> Disabling all the debugging stuff brings the numbers down, but things 
> still "feel" worse.  It's subjective, but there you are.  I'll continue to 
> test with whatever provides the most useful data.

The VM in 2.6.0 is pretty stable, but it hasn't gotten as much "tweaking" 
as the 2.4.x code. Which tends to show as bad performance under some 
loads.

The -mm code is likely to help a bit. I've been busy merging the stable
parts as Andrew sends it today and yesterday.

		Linus
