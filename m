Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131139AbRCGSU1>; Wed, 7 Mar 2001 13:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131140AbRCGSUS>; Wed, 7 Mar 2001 13:20:18 -0500
Received: from f112.law11.hotmail.com ([64.4.17.112]:5129 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S131139AbRCGSUE>;
	Wed, 7 Mar 2001 13:20:04 -0500
X-Originating-IP: [63.89.188.169]
From: "Ying Chen" <yingchenb@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: pthreads related issues
Date: Wed, 07 Mar 2001 10:19:32 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F112MQtFu9NHFto4pxw0000224a@hotmail.com>
X-OriginalArrivalTime: 07 Mar 2001 18:19:33.0115 (UTC) FILETIME=[2881F4B0:01C0A733]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think I forgot to include the subject on the email I sent last time.
Not sure how many people saw it. I'm trying to send this message again...

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


Ying

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

