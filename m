Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbVHQL7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVHQL7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 07:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVHQL7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 07:59:06 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:1965 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751086AbVHQL7F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 07:59:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t2L2xJt9nFBTxux6F+34qHzzp68d05Sk30cbwBvkFgDqqhtAZjp+WKTfXVLmv1S/wBjtdcC7a9GUW+Jl67nFNsJlIry6nONfnw55bmMoJh3Jxn9ODOQK8XUj5GncvXAGqqVUTxHrd64uS2EOf99GCNKfxsM5WgTj9J/0lCk5EsY=
Message-ID: <6bffcb0e05081704595bfccccf@mail.gmail.com>
Date: Wed, 17 Aug 2005 13:59:04 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4 for 2.6.12 and 2.6.13-rc6
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4302F0D8.6050409@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43001E18.8020707@bigpond.net.au>
	 <6bffcb0e05081614498879a72@mail.gmail.com>
	 <4302F0D8.6050409@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/17/05, Peter Williams <pwil3058@bigpond.net.au> wrote:
> I was intrigued by the fact that zaphod(d,d) and zaphod(d,0) take longer
> in real time but use less cpu.  I was assuming that this meant that some
> other job was getting some cpu but the schedstats data doesn't support
> that.  Also it wouldn't make sense anyway as you'd expect jobs doing the
> same amount of work to use roughly the same amount of cpu.  My latest
> theory is that your machine has hyper threads and this artifact is
> caused by the mechanism in the scheduler for handling tasks with
> differing priority in sibling hyper thread channels.  Does your system
> have hyper threads?

Yes. Please see my first mail:
> info:
> distro: debian 3.1
> cpu: pentium 4 (ht enabled)

Regards,
Michal Piotrowski
