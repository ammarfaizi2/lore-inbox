Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWEJB63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWEJB63 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 21:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWEJB63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 21:58:29 -0400
Received: from gold.veritas.com ([143.127.12.110]:60321 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751155AbWEJB63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 21:58:29 -0400
X-IronPort-AV: i="4.05,107,1146466800"; 
   d="scan'208"; a="59364736:sNHT27428360"
Date: Tue, 9 May 2006 12:25:43 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Hua Zhong <hzhong@gmail.com>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] fix can_share_swap_page() when !CONFIG_SWAP
In-Reply-To: <445FF78B.9060803@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0605091223190.19410@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0605071525550.2515@localhost.localdomain>
 <445ED495.3020401@yahoo.com.au> <Pine.LNX.4.64.0605081335030.7003@blonde.wat.veritas.com>
 <445FF78B.9060803@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 May 2006 01:58:28.0713 (UTC) FILETIME=[3B528590:01C673D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2006, Nick Piggin wrote:
> Hugh Dickins wrote:
> >
> >True; but I think Hua's patch is good as is for now, to fix
> >that inefficiency.  I do agree (as you know) that there's scope for
> >cleanup there, and that that function is badly named; but I'm still
> >unprepared to embark on the cleanup, so let's just get the fix in.
> 
> Sure. Queue it up for 2.6.18?

I'd be perfectly happy for Hua's one-liner to go into 2.6.17;
but that's up to Andrew.

Hugh
