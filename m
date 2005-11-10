Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbVKJMhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVKJMhL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVKJMhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:37:10 -0500
Received: from gold.veritas.com ([143.127.12.110]:15258 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750811AbVKJMhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:37:09 -0500
Date: Thu, 10 Nov 2005 12:35:55 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
In-Reply-To: <20051110120624.GB32672@elte.hu>
Message-ID: <Pine.LNX.4.61.0511101233530.6896@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com>
 <20051109181022.71c347d4.akpm@osdl.org> <Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com>
 <20051109185645.39329151.akpm@osdl.org> <20051110120624.GB32672@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 12:37:08.0588 (UTC) FILETIME=[76FAAAC0:01C5E5F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005, Ingo Molnar wrote:
> 
> yuck. What is the real problem btw? AFAICS there's enough space for a 
> 2-word spinlock in struct page for pagetables.

Yes.  There is no real problem.  But my patch offends good taste.

Hugh
