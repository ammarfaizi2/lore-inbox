Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWHRT12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWHRT12 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 15:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWHRT12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 15:27:28 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:55218 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932475AbWHRT11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 15:27:27 -0400
Date: Fri, 18 Aug 2006 12:19:54 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: manfred@colorfullife.com, ak@muc.de, mpm@selenic.com, marcelo@kvack.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, ak@suse.de,
       dgc@sgi.com
Subject: Re: [MODSLAB 3/7] A Kmalloc subsystem
In-Reply-To: <20060819041328.225b0170.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0608181219050.488@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
 <20060816022253.13379.76984.sendpatchset@schroedinger.engr.sgi.com>
 <20060816094358.e7006276.ak@muc.de> <Pine.LNX.4.64.0608161718160.19789@schroedinger.engr.sgi.com>
 <44E3FC4F.2090506@colorfullife.com> <Pine.LNX.4.64.0608172222210.29168@schroedinger.engr.sgi.com>
 <20060818161739.f7581645.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0608180956080.31844@schroedinger.engr.sgi.com>
 <20060819031916.85d5979e.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0608181138190.32621@schroedinger.engr.sgi.com>
 <20060819041328.225b0170.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2006, KAMEZAWA Hiroyuki wrote:

> But powerpc(NUMA) people has only SPARSEMEM. So test on powerpc will be 
> necessary, anyway.(of course, they doesn't have vmem_map)

Well they also have quite sophisticated page tables. They may be able to 
do the same thing as we have on IA64.

