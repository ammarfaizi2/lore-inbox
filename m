Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbVFWMxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVFWMxS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 08:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVFWMxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 08:53:17 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:56045 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S262447AbVFWMxO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 08:53:14 -0400
Message-ID: <42BAB0BA.1010100@cosmosbay.com>
Date: Thu, 23 Jun 2005 14:53:14 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64 prefetchw() function can take into account CONFIG_MK8
 / CONFIG_MPSC
References: <20050622.132241.21929037.davem@davemloft.net> <200506222242.j5MMgbxS009935@guinness.s2io.com> <20050622231300.GC14251@wotan.suse.de> <42BA81B2.4070108@cosmosbay.com> <20050623113150.GK14251@wotan.suse.de>
In-Reply-To: <20050623113150.GK14251@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 23 Jun 2005 14:53:09 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen a écrit :
> On Thu, Jun 23, 2005 at 11:32:34AM +0200, Eric Dumazet wrote:
> 
>>If we build a x86_64 kernel for an AMD64 or for an Intel EMT64, no need to 
>>use alternative_input.
>>Reserve alternative_input only for a generic kernel.
> 
> 
> An EM64T kernel should still boot on AMD64 and vice versa. Rejected.
> 
> -Andi
> 
> 

OK, I wrongly assumed the 'MK8' or 'MPSC' choices were like x86 choices :

A kernel compiled for a Pentium-4 will not run on a i486.

But then what is the meaning of the choice "Generic-x86-64" in the "Processor family" menu ?
The Help message is : CONFIG_GENERIC_CPU: Generic x86-64 CPU.

Eric
