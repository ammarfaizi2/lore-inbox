Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbTJECwA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 22:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTJECwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 22:52:00 -0400
Received: from intra.cyclades.com ([64.186.161.6]:9141 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262958AbTJECv6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 22:51:58 -0400
Date: Sat, 4 Oct 2003 23:50:07 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa1
In-Reply-To: <20031002152648.GB1240@velociraptor.random>
Message-ID: <Pine.LNX.4.44.0310042347190.1666-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Oct 2003, Andrea Arcangeli wrote:

> URL:
> Only in 2.4.23pre6aa1: 00_e-nodev-1
> 
> 	s/NODEV/ENODEV/ fixes from Vojtech.
> 
> Only in 2.4.23pre6aa1: 00_get_request_wait-race-1
> 
> 	Add missing smb_mb().

> Only in 2.4.23pre6aa1: 00_proc-readlink-1
> 
> 	Remeber to free tmp buffer (from spender)
> 
> Only in 2.4.23pre6aa1: 00_sync-buffer-scale-1
> 
> 	Don't take the bkl (the same paths runs w/o the bkl elsewhere), from
> 	Chris Mason.
> 
> Only in 2.4.23pre6aa1: 01_softirq-nowait-1
> 
> 	We must really keep executing softirqs or it may take
> 	a too long time before ksoftirqd gets some cpu time.
> 	For an embedded device you may want to remove this,
> 	on a server we need this still.
> 
> Only in 2.4.23pre6aa1: 30_19-nfs-kill-unlock-1
> 
> 	Ignore errors on exiting lock cleanups. From Trond.
> 
> Only in 2.4.23pre6aa1: 9999900_BH_Sync-remove-1
> 
> 	To really be able to help and not just waste some
> 	seek and cpu, wait_on_buffer should honour the
> 	BH_Sync, but this is late in 2.4, and so I prefer
> 	to get rid of it instead of giving it the full power
> 	it should have.
> 
> Only in 2.4.23pre6aa1: 9999_z-execve-race-1
> 
> 	Fix race in exit_mmap.

Andrea,

What about trying to merge this in mainline ? 

Will I have to look at them and merge them manually like I did with the VM 
changes ? 

:/

