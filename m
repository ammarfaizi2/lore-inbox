Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266798AbUHURiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266798AbUHURiG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 13:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266799AbUHURiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 13:38:06 -0400
Received: from holomorphy.com ([207.189.100.168]:8832 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266798AbUHURiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 13:38:03 -0400
Date: Sat, 21 Aug 2004 10:37:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm3
Message-ID: <20040821173759.GA3045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040820031919.413d0a95.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820031919.413d0a95.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 03:19:19AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm3/
> - Added three more bk trees:
> 	bk-fb:		Some ARM framebuffer driver (rmk)
> 	bk-mmc:		ARM-specific media drivers(?)
> 	bk-watchdog:	watchdog drivers
> - I'm totally unclear on what's happening with the release_task
>   sleep-while-atomic bug, and with the CPU hotplug BUG.  This kernel will
>   probably emit might_sleep warnings.  Turn off CONFIG_PREEMPT if it gets
>   irritating.
> - Added Nick Piggin's CPU scheduler to see what happens.  See inside the
>   patch for details.  Please test, benchmark, report.
> - This is (very) lightly tested.  Mainly a resync with various parties.

Oopsed almost instantly after I logged in as root on the one box I
can't do console logging on and can't afford downtime on. =(


-- wli
