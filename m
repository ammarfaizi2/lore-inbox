Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbWHJEZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbWHJEZD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 00:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161020AbWHJEZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 00:25:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34536 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161018AbWHJEZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 00:25:01 -0400
Message-ID: <44DC068C.5050205@osdl.org>
Date: Thu, 10 Aug 2006 21:24:44 -0700
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: a.p.zijlstra@chello.nl, tgraf@suug.ch, phillips@google.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
References: <44D976E6.5010106@google.com>	<20060809131942.GY14627@postel.suug.ch>	<1155132440.12225.70.camel@twins> <20060809.165846.107940575.davem@davemloft.net>
In-Reply-To: <20060809.165846.107940575.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Date: Wed, 09 Aug 2006 16:07:20 +0200
>
>   
>> Hmm, what does sk_buff::input_dev do? That seems to store the initial
>> device?
>>     
>
> You can run grep on the tree just as easily as I can which is what I
> did to answer this question.  It only takes a few seconds of your
> time to grep the source tree for things like "skb->input_dev", so
> would you please do that before asking more questions like this?
>   
C'mon cscope is your friend for this.
