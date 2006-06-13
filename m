Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWFMPzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWFMPzr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 11:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWFMPzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 11:55:47 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:51623 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932152AbWFMPzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 11:55:47 -0400
Date: Tue, 13 Jun 2006 08:55:33 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Hugh Dickins <hugh@veritas.com>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>
Subject: Re: zoned vm counters: per zone counter functionality
In-Reply-To: <448E4F05.9040804@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0606130854480.29796@schroedinger.engr.sgi.com>
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
 <20060612211255.20862.39044.sendpatchset@schroedinger.engr.sgi.com>
 <448E4F05.9040804@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006, Nick Piggin wrote:

> Is there any point in using a more meaningful namespace prefix than NR_
> for the zone_stat_items?
> 
> 
> > +enum zone_stat_item {
> > +	NR_STAT_ITEMS };
> > +

How about

NR_VM_ZONE_STAT_ITEMS ?

