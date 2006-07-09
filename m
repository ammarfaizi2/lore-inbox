Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161226AbWGIXyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161226AbWGIXyb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 19:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161228AbWGIXyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 19:54:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62902 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161226AbWGIXya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 19:54:30 -0400
Date: Sun, 9 Jul 2006 16:48:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Stephane Eranian <eranian@hpl.hp.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] i386: use thread_info flags for debug regs and IO  
 bitmaps
In-Reply-To: <200607091936_MC3-1-C489-B862@compuserve.com>
Message-ID: <Pine.LNX.4.64.0607091646210.5623@g5.osdl.org>
References: <200607091936_MC3-1-C489-B862@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Jul 2006, Chuck Ebbert wrote:
> 
> After I saw a ~7% gain in task-switch performance, I like it now
> even without perfmon2 in there.

So is the 7% performance gain visible with just that single patch 
(presumably because it avoids a cache miss associated with reading the 
processor state further away?)

If you have performance improvement numbers for just this one patch, I 
have no objections (but it would be good to then make those numbers part 
of the commit message).

			Linus
