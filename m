Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264326AbTL3BiL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 20:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264333AbTL3BiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 20:38:11 -0500
Received: from [24.35.117.106] ([24.35.117.106]:3723 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264326AbTL3BiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 20:38:09 -0500
Date: Mon, 29 Dec 2003 20:37:53 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Roger Luethi <rl@hellgate.ch>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
In-Reply-To: <20031230012551.GA6226@k3.hellgate.ch>
Message-ID: <Pine.LNX.4.58.0312292031450.6227@localhost.localdomain>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
 <20031230012551.GA6226@k3.hellgate.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Dec 2003, Roger Luethi wrote:

> I bet this is just yet another instance of a problem we've been
> discussing on lkml and linux-mm for several months now (although Linus
> asking for DMA presumably means it's not as well known as I thought
> it was).
> 
> Basically, when you need to resort to paging for getting work done on
> 2.6 you're screwed. Your bk export takes a lot more memory than you
> have RAM in your machine, right?

Right.  I have 120MB RAM and 256MB swap partition.  That corresponds to 
the 85 to 90 percent top says I am spending in iowait.
