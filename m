Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262978AbVHELFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262978AbVHELFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 07:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262973AbVHELFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 07:05:36 -0400
Received: from smtp.bredband2.net ([82.209.166.4]:4630 "EHLO
	smtp.bredband2.net") by vger.kernel.org with ESMTP id S262972AbVHELEw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 07:04:52 -0400
Message-ID: <42F347D2.7000207@home.se>
Date: Fri, 05 Aug 2005 13:04:50 +0200
From: =?ISO-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: lockups with netconsole on e1000 on media insertion
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to hunt down a hard lockup issue with some hardware of 
mine, but I've possibly hit a kernel bug instead. When using netconsole 
on my e1000, if I unplug the cable and then re-plug it, the machine 
locks up hard. It manages to print the "link up" message on the screen, 
but nothing after that. Now, I wonder if this is supposed to be so? I 
tried this on 4 different configurations, 2.6.13-rc5 and 2.6.12 with and 
without "noapic acpi=off", same result on all of them. I've tried with 1 
and 3 other NICs in the machine at the same time.

It seems to be working fine on other NICs, such as rtl8139 and 3c59x. 
Any ideas on how to debug this further? (Btw, is there an easy way of 
"inserting" dmesg messages manually?)

---
John Bäckstrand
