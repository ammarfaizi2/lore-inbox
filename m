Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbWFNQPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWFNQPF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 12:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbWFNQPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 12:15:05 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:48322 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965021AbWFNQPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 12:15:03 -0400
Date: Wed, 14 Jun 2006 09:14:42 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Hugh Dickins <hugh@veritas.com>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>
Subject: Re: zoned vm counters: per zone counter functionality
In-Reply-To: <448F64A0.9090705@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0606140914060.3919@schroedinger.engr.sgi.com>
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
 <20060612211255.20862.39044.sendpatchset@schroedinger.engr.sgi.com>
 <448E4F05.9040804@yahoo.com.au> <Pine.LNX.4.64.0606130854480.29796@schroedinger.engr.sgi.com>
 <448F64A0.9090705@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2006, Nick Piggin wrote:

> I guess that's OK.
> 
> Hmm, then NR_ANON would become VM_ZONE_STAT_NR_ANON? That might be a bit
> long for your tastes, maybe the prefix could be hidden by "clever" macros?

I only changed the NR_STAT_ITEMS but kept the rest since these symbols are 
used frequently.

