Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWCPPD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWCPPD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 10:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWCPPD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 10:03:27 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:8275 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751203AbWCPPD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 10:03:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=MluYzPLKmjlhZM50tCUjVcbNBEraM3oI/9nVdYYE82yT6strL8iB5QCuw/eO6PgVv6u+Rix8gNGL7wlSW9MSonWQ1sS2Z6lsiMQhwSvmmqYk7D67GIu6WOfBvH2+yaJgp2NR2eXT59xxzqHG6c6JUNQjPu8+1pe1lV39nGCR+dw=  ;
Message-ID: <44193733.9060003@yahoo.com.au>
Date: Thu, 16 Mar 2006 21:00:19 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: rdreier@cisco.com, bos@pathscale.com, Hugh@veritas.com, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>	<ada4q27fban.fsf@cisco.com>	<1141948516.10693.55.camel@serpentine.pathscale.com>	<ada1wxbdv7a.fsf@cisco.com>	<1141949262.10693.69.camel@serpentine.pathscale.com>	<20060309163740.0b589ea4.akpm@osdl.org>	<1142470579.6994.78.camel@localhost.localdomain>	<ada3bhjuph2.fsf@cisco.com>	<1142475069.6994.114.camel@localhost.localdomain>	<adaslpjt8rg.fsf@cisco.com>	<1142477579.6994.124.camel@localhost.localdomain>	<20060315192813.71a5d31a.akpm@osdl.org>	<1142485103.25297.13.camel@camp4.serpentine.com>	<20060315213813.747b5967.akpm@osdl.org>	<ada8xrbszmx.fsf@cisco.com>	<20060315221716.19a92762.akpm@osdl.org>	<44190934.7040207@yahoo.com.au> <20060316013914.430a2542.akpm@osdl.org>
In-Reply-To: <20060316013914.430a2542.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Andrew Morton wrote:
>>
>> > vm_insert_page() mucks around with rmap-named functions which don't
>> > actually do rmap
>>
>> What functions are those? I don't see.
>>
>> > and sports apparently-incorrect comments wrt
>> > PageReserved().
>>
>> What's the comment? Are we looking at the same vm_insert_page?
> 
> 
> vm_insert_page() calls insert_page().
> 

Oh OK. I guess I didn't think insert_page was rmap-named. Yes, it looks
like the comment on that one is wrong.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
