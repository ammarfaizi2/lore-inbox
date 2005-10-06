Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbVJFKFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbVJFKFU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 06:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVJFKFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 06:05:20 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:1433 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750781AbVJFKFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 06:05:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=QSwVEDTM64ybhjeZxkhnqI9xYtUQvpwufvTT9WUUYOMK3kAtBoDkkQ4fmFHukeaH7h6XYFXikiFVGTx+JhRkUb8iwhOg5JiMtjXYNCLT8qouiCT/YkkYdF7X61WShpP1fm42b5ucCPhOZyqOJKgcZfU4u7wRPUPYnMa8irMJVH0=  ;
Message-ID: <4344F6A4.2070707@yahoo.com.au>
Date: Thu, 06 Oct 2005 20:04:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel performance update - 2.6.14-rc3
References: <200510052115.j95LFgg07836@unix-os.sc.intel.com> <1128579372.2960.6.camel@laptopd505.fenrus.org>
In-Reply-To: <1128579372.2960.6.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>dbench is catching some attention.  We just ran it with default
>>parameter.  I don't think default parameter is the right one to use
>>on some of our configurations.  For example, it shows +100% improvement
> 
> 
> never ever consider dbench a serious benchmark; the thing is you can
> make dbench a lot better very easy; just make the kernel run one thread
> at a time until completion. dbench really gives very variable results,
> but it is not really possible to say if +100% or -100% is an improvement
> or a degredation for real life. So please just don't run it, or at least
> don't interpret the results in a "higher is better" way.
> 

As a disk IO performance benchmark you are absolutely right.

Some people like using it to test VM scalability and throughput
if it is being used on tmpfs. In that case the results are
generally more stable.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
