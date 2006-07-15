Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWGOFhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWGOFhS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 01:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWGOFhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 01:37:18 -0400
Received: from fmr18.intel.com ([134.134.136.17]:11476 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932500AbWGOFhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 01:37:16 -0400
Message-ID: <44B87E94.7000602@linux.intel.com>
Date: Sat, 15 Jul 2006 07:35:16 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, netdev@vger.kernel.org
Subject: Re: [-mm patch] remove net/core/skbuff.c:skb_queue_lock_key
References: <20060713224800.6cbdbf5d.akpm@osdl.org> <20060715003519.GF3633@stusta.de>
In-Reply-To: <20060715003519.GF3633@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Thu, Jul 13, 2006 at 10:48:00PM -0700, Andrew Morton wrote:
>> ...
>> Changes since 2.6.18-rc1-mm1:
>> ...
>> +lockdep-split-the-skb_queue_head_init-lock-class.patch
>>
>>  lockdep-versus-net fix.
>> ...
> 
> skb_queue_lock_key is no longer used.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 

Acked-by: Arjan van de Ven <arjan@linux.intel.com>
