Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbUAAB2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 20:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbUAAB2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 20:28:04 -0500
Received: from [24.35.117.106] ([24.35.117.106]:21120 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265315AbUAAB1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 20:27:52 -0500
Date: Wed, 31 Dec 2003 20:27:34 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Roger Luethi <rl@hellgate.ch>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
In-Reply-To: <20031231210354.GA9804@k3.hellgate.ch>
Message-ID: <Pine.LNX.4.58.0312312014480.3069@localhost.localdomain>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
 <20031230012551.GA6226@k3.hellgate.ch> <Pine.LNX.4.58.0312292031450.6227@localhost.localdomain>
 <20031230132145.B32120@hexapodia.org> <20031230194051.GD22443@holomorphy.com>
 <20031230222403.GA8412@k3.hellgate.ch> <Pine.LNX.4.58.0312301921510.3193@localhost.localdomain>
 <20031231101741.GA4378@k3.hellgate.ch> <20031231112119.GB3089@suse.de>
 <20031231210354.GA9804@k3.hellgate.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Dec 2003, Roger Luethi wrote:

> For the systematic testing, I used "qsbench -p 4 -m 96" on a 256 MB
> machine. This allowed the kernel to achieve high performance with
> unfairness -- that's what 2.4 does: One process dominates all others
> and finishes very early, taking away most of the memory pressure.
> The spike for qsbench in 2.5.39 remains if only one process is forked
> (-p1 -m 384), though.
> 
> I asked for the bk export numbers with 2.5.39 because I'm curious how
> close to qsbench the behavior really is.

2.5.39 won't compile for me "out of the box".  I thought it might have 
been the toolset, but I was running RH8 and it has gcc 3.2.  Was there a 
big change between 3.2 and 3.3.2 in Fedora Core 1?  The reason I ask is 
that I also can't get NISTNet to compile on Fedora Core 1 or RHEL WS 3.  
It looks like incompatible libraries.
