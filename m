Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbVKJPU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbVKJPU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 10:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbVKJPU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 10:20:59 -0500
Received: from silver.veritas.com ([143.127.12.111]:23978 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750808AbVKJPU6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 10:20:58 -0500
Date: Thu, 10 Nov 2005 15:19:38 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Richard Henderson <rth@twiddle.net>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/15] mm: fill arch atomic64 gaps
In-Reply-To: <200511101438.39768.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0511101515530.8566@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0511100153350.5814@goblin.wat.veritas.com> <200511101438.39768.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 15:20:53.0260 (UTC) FILETIME=[56F0A4C0:01C5E60A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005, Andi Kleen wrote:
> On Thursday 10 November 2005 02:56, Hugh Dickins wrote:
> > alpha, s390, sparc64, x86_64 are each missing some primitives from their
> > atomic64 support: fill in the gaps I've noticed by extrapolating asm,
> > follow the groupings in each file, and say "int" for the booleans rather
> > than long or long long.  But powerpc and parisc still have no atomic64.
> 
> x86-64 part looks ok thanks. I assume you will take care of the merge
> or do you want me to take that hunk?

Thanks for checking, Andi.  Don't worry about it for now.  That patch
series is currently sitting somewhere well away from Andrew's breakfast.
I'll wait and see where it goes.

Hugh
