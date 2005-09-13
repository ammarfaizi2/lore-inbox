Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbVIMQ32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbVIMQ32 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbVIMQ32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:29:28 -0400
Received: from gold.veritas.com ([143.127.12.110]:55980 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964850AbVIMQ31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:29:27 -0400
Date: Tue, 13 Sep 2005 17:29:01 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert mempolicy.c to nodemasks, take 2
In-Reply-To: <20050913040107.GA21417@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0509131722380.17189@goblin.wat.veritas.com>
References: <20050913040107.GA21417@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Sep 2005 16:29:15.0870 (UTC) FILETIME=[4853BFE0:01C5B880]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005, Andi Kleen wrote:
> Convert mempolicies to nodemask_t
>....
> This version includes the fixes for the issues Paul noted.

I couldn't boot 2.6.13-mm3 with CONFIG_NUMA_EMU=y yesterday, oopsed
on some bad address in interleave_nodes().  But replacing the old
version of the patch with this, I can now boot it again - thanks.

Hugh
