Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWAZRp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWAZRp3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 12:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWAZRp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 12:45:29 -0500
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:24292 "EHLO
	mtiwmhc11.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1751100AbWAZRp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 12:45:29 -0500
Message-ID: <43D90AB2.3020705@lwfinger.net>
Date: Thu, 26 Jan 2006 11:45:22 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How to dump stack for kernel threads
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a driver that I am debugging, there is a periodic task that runs every minute. Intermittently, it 
destructively interrupts some other activity in the driver, but I have not been able to find the 
section that is not thread-safe. I have included a dump_stack call at the point where the problem is 
evident, but the current thread is OK. How would I generate a stack dump of the rest of this 
driver's kernel threads? Dumping all kernel threads would also be OK.

Thanks,

Larry
