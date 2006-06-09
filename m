Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWFIPzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWFIPzt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbWFIPzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:55:49 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:58596 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030245AbWFIPzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:55:47 -0400
Date: Fri, 9 Jun 2006 08:55:22 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, hugh@veritas.com, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, ak@suse.de, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 06/14] Add per zone counters to zone node and global VM
 statistics
In-Reply-To: <20060608210101.155e8d4f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606090855050.31570@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
 <20060608230310.25121.77780.sendpatchset@schroedinger.engr.sgi.com>
 <20060608210101.155e8d4f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006, Andrew Morton wrote:

> > +char *vm_stat_item_descr[NR_STAT_ITEMS] = { "mapped","pagecache" };
> 
> static?

It is accessed from driver/base/node.c.


