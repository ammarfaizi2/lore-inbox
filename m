Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbUK1PKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbUK1PKj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 10:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbUK1PKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 10:10:39 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61097 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261487AbUK1PKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 10:10:35 -0500
Date: Sun, 28 Nov 2004 12:37:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Suspend 2 merge
Message-ID: <20041128113708.GQ1417@openzaurus.ucw.cz>
References: <20041127220752.16491.qmail@science.horizon.com> <20041128082912.GC22793@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041128082912.GC22793@wiggy.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Lucky you.  My machine takes minutes.
> > (To be precise, it prints about a line and a half of dots in the
> > count_data_pages() loop, and often takes 2 seconds per dot.)
> 
> It also seems to vary wildly. Most of the time it goes pretty fast for
> me (under one minute) but occasionaly it will take well over 10 minutes.
> Never managed to time it exactly since my battery tends to run out in
> the middle of a suspend when that happens.

It depends on memory fragmentation; after updatedb it tends to be slow.
Patch exists, see archives.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

