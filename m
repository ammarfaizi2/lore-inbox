Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129712AbRCFX4j>; Tue, 6 Mar 2001 18:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129719AbRCFX43>; Tue, 6 Mar 2001 18:56:29 -0500
Received: from f41.law11.hotmail.com ([64.4.17.41]:45322 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129712AbRCFX40>;
	Tue, 6 Mar 2001 18:56:26 -0500
X-Originating-IP: [63.89.188.109]
From: "Ying Chen" <yingchenb@hotmail.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 06 Mar 2001 15:55:55 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F41oVQAiEGKROptzzpY000014a6@hotmail.com>
X-OriginalArrivalTime: 06 Mar 2001 23:55:55.0237 (UTC) FILETIME=[FB93A150:01C0A698]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have two questions on Linux pthread related issues. Would anyone be able 
to help?

1. Does any one have some suggestions (pointers) on good kernel Linux thread 
libraries?
2. We ran multi-threaded application using Linux pthread library on 2-way 
SMP and UP intel platforms (with both 2.2 and 2.4 kernels). We see 
significant increase in context switching when moving from UP to SMP, and 
high CPU usage with no performance gain in turns of actual work being done 
when moving to SMP, despite the fact the benchmark we are running is 
CPU-bound. The kernel profiler indicates that the a lot of kernel CPU ticks 
went to scheduling and signaling overheads. Has anyone seen something like 
this before with pthread applications running on SMP platforms? Any 
suggestions or pointers on this subject?

Thanks a lot!

Ying



_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

