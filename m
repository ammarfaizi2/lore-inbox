Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbUKDUkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbUKDUkE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbUKDUey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:34:54 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:17094 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262415AbUKDUbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:31:22 -0500
Message-ID: <418A918C.5020108@nortelnetworks.com>
Date: Thu, 04 Nov 2004 14:31:08 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
References: <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <418A8439.2000003@spymac.com>
In-Reply-To: <418A8439.2000003@spymac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ingo Molnar wrote:

>> - implemented a first version of the priority inheritance handling and
>>   priority inversion avoidance logic. This feature, after some initial
>>   stability problems, solved the jackd and rtc_wakeup latencies that
>>   were introduced by the ultra-finegrained locking in the -V series.

How does this play with Inaky's priority inheritance patch?  Could they be 
combined somehow?

Chris
