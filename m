Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751557AbWCFTj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbWCFTj5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbWCFTj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:39:57 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:8869 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751561AbWCFTjz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:39:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=levZvJRvM1TdKQ2kGn5MP2msv4Gy/ySUKWAzT/MMcoDHFfH9nZ4YziRSvDXgufZnoVeITO239f8cG6ykltS/ThjYzUV0XEoignntG+JSbcR8/cHpkWHyTERWK9Q1HKAb8U+ziu1xNQBvV7Qfajo92bVsuZlI+VLv09I8rjqrEbU=
Message-ID: <41b516cb0603061139qeb60783md1b088ffaa216bf2@mail.gmail.com>
Date: Mon, 6 Mar 2006 11:39:54 -0800
From: "Chris Leech" <chris.leech@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/8] [I/OAT] DMA memcpy subsystem
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060303.174048.14793187.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060303214036.11908.10499.stgit@gitlost.site>
	 <20060303214220.11908.75517.stgit@gitlost.site>
	 <20060303.174048.14793187.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/06, David S. Miller <davem@davemloft.net> wrote:
> > +static spinlock_t dma_list_lock;
>
> Please use DEFINE_SPINLOCK().
>
> > +static void dma_chan_free_rcu(struct rcu_head *rcu) {
>
> Newline before the brace please.
>
> > +static void dma_async_device_cleanup(struct kref *kref) {
>
> Newline before the brace please.
>
> > +struct dma_chan_percpu
> > +{
>
> Left brace on the same line as "struct dma_chan_percpu" please.
>
> > +struct dma_chan
> > +{
>
> Similarly.
>
> Otherwise this patch looks mostly ok.

Thanks Dave,

I'll apply these and other feedback and get updated patches generated.

- Chris
