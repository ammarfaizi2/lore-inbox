Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267170AbUJFEaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267170AbUJFEaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 00:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267180AbUJFEaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 00:30:21 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:35199 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267170AbUJFEaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 00:30:18 -0400
Message-ID: <416374D5.50200@yahoo.com.au>
Date: Wed, 06 Oct 2004 14:30:13 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, mingo@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Default cache_hot_time value back to 10ms
References: <200410060042.i960gn631637@unix-os.sc.intel.com> <20041005205511.7746625f.akpm@osdl.org>
In-Reply-To: <20041005205511.7746625f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
> 
>>This value was default to 10ms before domain scheduler, why does domain
>> scheduler need to change it to 2.5ms? And on what bases does that decision
>> take place?  We are proposing change that number back to 10ms.
> 
> 
> It sounds like this needs to be runtime tunable?
> 

I'd say it is probably too low level to be a useful tunable (although
for testing I guess so... but then you could have *lots* of parameters
tunable).

I don't think there was a really good reason why this value is 2.5ms.
