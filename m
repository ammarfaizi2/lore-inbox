Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030497AbWHIFvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030497AbWHIFvj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 01:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbWHIFvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 01:51:39 -0400
Received: from smtp-out.google.com ([216.239.45.12]:49225 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030492AbWHIFvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 01:51:38 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=V9qPspZ9gjyBUxqLpRbli4DCgXh7wV7bJm7cYpEY5gITJAxq/sjQJvCU3LoRRT9gY
	MPVbYRWovnre6zVdjd8LQ==
Message-ID: <44D977D8.5070306@google.com>
Date: Tue, 08 Aug 2006 22:51:20 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 8/9] 3c59x driver conversion
References: <20060808193325.1396.58813.sendpatchset@lappy> <20060808193447.1396.59301.sendpatchset@lappy> <44D9191E.7080203@garzik.org>
In-Reply-To: <44D9191E.7080203@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Peter Zijlstra wrote:
>> Update the driver to make use of the netdev_alloc_skb() API and the
>> NETIF_F_MEMALLOC feature.
> 
> NETIF_F_MEMALLOC does not exist in the upstream tree...  nor should it, 
> IMO.

Elaborate please.  Do you think that all drivers should be updated to
fix the broken blockdev semantics, making NETIF_F_MEMALLOC redundant?
If so, I trust you will help audit for it?

> netdev_alloc_skb() is in the tree, and that's fine.
