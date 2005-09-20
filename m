Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbVITVpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbVITVpJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 17:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVITVpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 17:45:08 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:63515 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1750770AbVITVpH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 17:45:07 -0400
Message-ID: <433082DE.3060308@cosmosbay.com>
Date: Tue, 20 Sep 2005 23:45:02 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Cc: netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org
Subject: [PATCH] Adds sys_set_mempolicy() in include/linux/syscalls.h , Re:
 [PATCH, netfilter] NUMA aware ipv4/netfilter/ip_tables.c
References: <432EF0C5.5090908@cosmosbay.com> <200509191948.55333.ak@suse.de> <432FDAC5.3040801@cosmosbay.com> <200509201830.20689.ak@suse.de>
In-Reply-To: <200509201830.20689.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen a écrit :
> On Tuesday 20 September 2005 11:47, Eric Dumazet wrote:
> 
> 
> 
> I would prefer if random code didn't mess with mempolicy internals
> like this. Better just call sys_set_mempolicy() 
> 
> -Andi
> 
> 


OK but this prior patch seems necessary :

- Adds sys_set_mempolicy() in include/linux/syscalls.h

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

