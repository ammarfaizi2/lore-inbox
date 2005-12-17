Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbVLQR7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbVLQR7S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 12:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbVLQR7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 12:59:18 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:51061 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932619AbVLQR7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 12:59:18 -0500
Date: Sat, 17 Dec 2005 11:58:32 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Dianogsing a hard lockup
In-reply-to: <5kMWZ-2PF-7@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43A451C8.9090304@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5kMWZ-2PF-7@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> Hi list,
> 
> 
> some time after I load drivers (any, rt2500 or via ndiswrap) for a 
> rt2500-based wlan card, the box locks up hard. Sysrq does not work, so I 
> suppose it is during irq-disabled context. How could I find out where this 
> happens?
> 
> 
> Jan Engelhardt

Try nmi_watchdog=1 on the kernel command line. That may get you a stack 
trace for the lockup.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

