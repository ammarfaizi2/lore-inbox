Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266663AbUJFBkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266663AbUJFBkU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 21:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUJFBkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 21:40:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53123 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266663AbUJFBkQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 21:40:16 -0400
Message-ID: <41634CF3.5040807@pobox.com>
Date: Tue, 05 Oct 2004 21:40:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata,
 VIA SATA))
References: <4136E4660006E2F7@mail-7.tiscali.it> <41634236.1020602@pobox.com> <52is9or78f.fsf_-_@topspin.com> <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au>
In-Reply-To: <41634A34.20500@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> When you say low latency, you mean small lock hold times, *and*
> cond_rescheds placed everywhere - it is this second requirement
> that isn't the cleanest way of doign things.
> 
> With preempt, sure you still need small lock hold times. No big
> deal.

And with preempt you're still hiding stuff that needs fixing.  And when 
it gets fixed, you don't need preempt.

Therefore, preempt is just a hack that hides stuff that wants fixing anyway.

	Jeff



