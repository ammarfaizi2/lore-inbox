Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVCWQcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVCWQcU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 11:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVCWQcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 11:32:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17096 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261611AbVCWQcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 11:32:17 -0500
Message-ID: <42419A00.1030206@pobox.com>
Date: Wed, 23 Mar 2005 11:32:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Henderson <rth@twiddle.net>
CC: Andrew Morton <akpm@osdl.org>, Pawe__ Sikora <pluto@pld-linux.org>,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: alpha spinlock.h update
References: <20050322130145.69915bea.akpm@osdl.org> <20050323144922.GA19677@twiddle.net>
In-Reply-To: <20050323144922.GA19677@twiddle.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson wrote:
> On Tue, Mar 22, 2005 at 01:01:45PM -0800, Andrew Morton wrote:
> 
>>I had the impression Richard planned on something more sophisticated
>>than this??
> 
> 
> Indeed.  I suppose I can pass it along to avoid repeated "it doesn't build"
> messages, but an smp kernel doesn't run.  *All* processes spawned by init(1)
> die with SIGILL very very shortly.  I can only guess that there's been some
> change to flushing (icache or tlb) that went wrong.

I wonder if its 4-level page tables.   I think DaveM, in another thread, 
is chasing flush-<something> issues right now, on sparc64.

	Jeff


