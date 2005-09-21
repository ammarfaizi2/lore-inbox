Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbVIUNs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbVIUNs6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 09:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbVIUNs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 09:48:58 -0400
Received: from rrcs-67-78-243-58.se.biz.rr.com ([67.78.243.58]:28046 "EHLO
	mail.concannon.net") by vger.kernel.org with ESMTP id S1750930AbVIUNs5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 09:48:57 -0400
Message-ID: <433164F4.40205@concannon.net>
Date: Wed, 21 Sep 2005 09:49:40 -0400
From: Michael Concannon <mike@concannon.net>
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1.centos4 (X11/20050721)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: spurious mouse clicks
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought it was my imagination at first, but now I have some slightly 
more convincing evidence of what is going on...

With 2.6.13.1 & 2 as I move my mouse around the screen, I get random 
clicks on things the mouse passes.  Seems to happen more often with the 
first move from idle, but in general, it is just totally random...

With 2.6.9-11.EL and 2.6.12.6 (stock kernel.org) I do NOT get this.

Anyone else seeing this?

I would blame the OS/WM/X, as I have recently upgraded to CentOS4, but 
now I have tried a few different kernels in the process of getting a 
stable config for my wireless setup and I am convinced that the only 
variable that seems to matter is the kernel version.  I have had this 
laptop for about a year and prior configs never had any mouse issues.

Config:
2.6.13.1 & 2 from kernel.org .config is the "default" from CentOS 4 - 
happy to post if anyone is interested.
Machine:
    Dell 8600 Pentium M 2GHz 1.5G ram
Mouse:
    touch pad PS/2 - dmesg/proc do not seem to show anything more 
specific than that
    PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
OS:
    CentOS 4.1 - KDE 3.3 stock config

/mike
