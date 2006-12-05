Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968393AbWLEQF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968393AbWLEQF2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 11:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968396AbWLEQF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 11:05:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:47329 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S968393AbWLEQF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 11:05:27 -0500
Date: Tue, 5 Dec 2006 08:05:16 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, akpm@osdl.org,
       apw@shadowen.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
In-Reply-To: <Pine.LNX.4.64.0612050952500.11807@skynet.skynet.ie>
Message-ID: <Pine.LNX.4.64.0612050803000.11213@schroedinger.engr.sgi.com>
References: <20061130170746.GA11363@skynet.ie> <20061130173129.4ebccaa2.akpm@osdl.org>
 <Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie> <20061201110103.08d0cf3d.akpm@osdl.org>
 <20061204140747.GA21662@skynet.ie> <20061204113051.4e90b249.akpm@osdl.org>
 <Pine.LNX.4.64.0612041946460.26428@skynet.skynet.ie> <20061204143435.6ab587db.akpm@osdl.org>
 <Pine.LNX.4.64.0612042338390.2108@skynet.skynet.ie>
 <20061205101629.5cb78828.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0612050952500.11807@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006, Mel Gorman wrote:

> That is one possibility. There are people working on fake nodes for containers
> at the moment. If that pans out, the infrastructure would be available to
> create one node per DIMM.

Right that is a hack in use for one project. We would be adding huge 
amounts of VM overhead if we do a node per DIMM.

So a desktop system with two dimms is to be treated like a NUMA 
system? Or how else do we deal with the multitude of load balancing 
situations that the additional nodes will generate?



