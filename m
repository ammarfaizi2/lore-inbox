Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbVISXNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbVISXNL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 19:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVISXNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 19:13:10 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:34258 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964792AbVISXNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 19:13:09 -0400
Date: Mon, 19 Sep 2005 16:13:03 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Andi Kleen <ak@suse.de>, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: NUMA mempolicy /proc code in mainline shouldn't have been merged
In-Reply-To: <20050919154813.52f5b706.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0509191607020.27528@schroedinger.engr.sgi.com>
References: <200509101120.19236.ak@suse.de> <20050919194038.GB12810@verdi.suse.de>
 <Pine.LNX.4.62.0509191426250.26388@schroedinger.engr.sgi.com>
 <200509192356.56300.ak@suse.de> <20050919154813.52f5b706.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2005, Andrew Morton wrote:

> No fair.  I've never worked on big HPC systems and any feedback from the
> field which Christoph can provide is really important in helping us
> understand what features the kernel needs to offer.  I would expect that
> SGI engineering have a better understanding of HPC users' needs than pretty
> much anyone else in the world.

We would be glad to do be more clean on these issues. Its difficult 
to see how that can happen when the discussion is blocked on 
principle. I have discussed various scenarios in long discussion 
threads with Andi. The answer "My code is simple and cannot be changed" 
wont get us anywhere.

> It's a shame that SGI engineering aren't better at communicating those
> needs to wee little kernel developers.  And we need to get better at this

I wish I knew how we can improve the communication. I have discussed this 
for two months now and tried to respond to every objection and concern 
that came up.

> because, as you say, external policy control is going to be a ton harder to
> swallow than /proc/pid/numa_maps.

Could we just do the numa_maps in the right way now and do a code cleanup 
for 2.6.14 (node_maps, user interface / system interface separation)? We can 
then think longer term about how the memory of a process can be managed.
