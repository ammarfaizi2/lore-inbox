Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbVJLH0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbVJLH0s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 03:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVJLH0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 03:26:48 -0400
Received: from silver.veritas.com ([143.127.12.111]:42411 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750907AbVJLH0r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 03:26:47 -0400
Date: Wed, 12 Oct 2005 08:25:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: David Gibson <david@gibson.dropbear.id.au>
cc: Adam Litke <agl@us.ibm.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, ak@suse.de
Subject: Re: [PATCH 2/3] hugetlb: Demand fault handler
In-Reply-To: <20051012060934.GA14943@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0510120824320.4681@goblin.wat.veritas.com>
References: <1129055057.22182.8.camel@localhost.localdomain>
 <1129055559.22182.12.camel@localhost.localdomain> <20051012060934.GA14943@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 12 Oct 2005 07:26:41.0031 (UTC) FILETIME=[4A1C4970:01C5CEFE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2005, David Gibson wrote:
> 
> I'm not sure this does fully deal with truncation, I'm afraid - it
> will deal with a truncation well before the fault, but not a
> concurrent truncate().  We'll need the truncate_count/retry logic from
> do_no_page, I think.  Andi/Hugh, can you confirm that's correct?

Very likely you're right, but I already explained to Adam privately
that I won't get to look at all this before tomorrow - sorry.

Hugh
