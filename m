Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVHAHv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVHAHv2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 03:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVHAHv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 03:51:28 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:37019 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S262024AbVHAHv1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 03:51:27 -0400
Message-ID: <42EDD473.3010308@free.fr>
Date: Mon, 01 Aug 2005 09:51:15 +0200
From: greg <ustrel@free.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Clock resolution / RT preemption
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I'm looking for a timer resolution lower than 1 ms (and monotonic clock 
rate) destined to be used with some network code running on x86 
platforms. Would you please provide me with informations about how to 
get/implement this.

AFAIK, there's a "high resultion timer" patch hanging around, but 
there's not much informations with regard to portability (specific 
hardware requirements ?), scalability, integration with RT patches.
I understand the POSIX 1003.1b Clocks and Timers system calls are not 
fully available within the linux kernel (and libc ?), am I right on that ?

One more question : I believe Ingo's preemption patch run 
timers/interrupt handlers within kernel threads, how should I assign 
specific priority to address my goals without compromising system 
stability ?
