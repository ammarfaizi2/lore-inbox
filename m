Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVH1Q1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVH1Q1A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 12:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVH1Q1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 12:27:00 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:27939 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751155AbVH1Q07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 12:26:59 -0400
Date: Sun, 28 Aug 2005 10:26:41 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [patch] IBM HDAPS accelerometer driver.
In-reply-to: <4GrEp-3E2-21@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4311E5C1.8020306@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4FOa3-8fm-39@gated-at.bofh.it> <4GlyV-3Rk-3@gated-at.bofh.it>
 <4GqyE-2bk-19@gated-at.bofh.it> <4GrEp-3E2-21@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> If you need that, it belongs into the kernel.

Why? By that logic, any realtime app would have to be built into the 
kernel. There is no need to put this kind of functionality into the 
kernel itself. mlockall() and SCHED_FIFO scheduling priority should 
ensure that the daemon should be able to run whenever it needs to.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

