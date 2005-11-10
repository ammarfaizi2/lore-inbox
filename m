Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbVKJVhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVKJVhc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbVKJVhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:37:32 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:14828 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932103AbVKJVhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:37:31 -0500
Date: Thu, 10 Nov 2005 13:37:19 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, hugh@veritas.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
In-Reply-To: <20051110042613.7a585dec.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0511101335140.16283@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com>
 <20051109181022.71c347d4.akpm@osdl.org> <Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com>
 <20051109185645.39329151.akpm@osdl.org> <20051110120624.GB32672@elte.hu>
 <20051110042613.7a585dec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005, Andrew Morton wrote:

> spinlock in struct page, and the size of the spinlock varies a lot according
> to config.  The only >wordsize version we really care about is
> CONFIG_PREEMPT, NR_CPUS >= 4.  (which distros don't ship...)

Suse, Debian and Redhat ship such kernels.

