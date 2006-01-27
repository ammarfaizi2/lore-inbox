Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWA0DBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWA0DBD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 22:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWA0DBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 22:01:02 -0500
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:8404 "EHLO
	mtiwmhc13.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1030264AbWA0DBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 22:01:00 -0500
Message-ID: <43D98CE2.9020700@lwfinger.net>
Date: Thu, 26 Jan 2006 21:00:50 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to dump stack for kernel threads
References: <43D90AB2.3020705@lwfinger.net> <Pine.LNX.4.61.0601262214430.27891@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601262214430.27891@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>In a driver that I am debugging, there is a periodic task that runs every
>>minute. Intermittently, it destructively interrupts some other activity in the
>>driver, but I have not been able to find the section that is not thread-safe. I
>>have included a dump_stack call at the point where the problem is evident, but
>>the current thread is OK. How would I generate a stack dump of the rest of this
>>driver's kernel threads? Dumping all kernel threads would also be OK.
> 
> 
> Sysrq+T. Behind the jungle, there's a function doing what you want.
> 
> 
> Jan Engelhardt

Thanks for the tip. It won't work for me from the keyboard but your suggestion got me into a call to 
handle_sysrq.

Larry

