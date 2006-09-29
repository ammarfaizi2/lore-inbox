Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161242AbWI2A6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161242AbWI2A6J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161243AbWI2A6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:58:09 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:7613 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161242AbWI2A6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:58:07 -0400
Date: Fri, 29 Sep 2006 02:57:45 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: oom kill oddness.
In-Reply-To: <20060928171706.bee0c50b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0609290231460.6761@scrub.home>
References: <20060927205435.GF1319@redhat.com> <Pine.LNX.4.64.0609290035060.6762@scrub.home>
 <20060928171706.bee0c50b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 28 Sep 2006, Andrew Morton wrote:

> Kernel versions please, guys.  There have been a lot of oom-killer changes
> post-2.6.18.

Last I tested this was with 2.6.18.
The latest changes to vmscan.c should help...

> > If someone wants to play with the problem, the example program below 
> > triggers the problem relatively easily (booting with only little ram 
> > helps), it starts a number of readers, which should touch a bit more 
> > memory than is available and a few writers, which occasionally allocate 
> > memory.
> > 
> 
> How much ram, how much swap?

I tested it with 32MB and 64MB and plenty of swap.

bye, Roman
