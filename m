Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVK0Cou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVK0Cou (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 21:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVK0Cou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 21:44:50 -0500
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:12783 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1750825AbVK0Cou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 21:44:50 -0500
Message-ID: <43891D97.4000404@lwfinger.net>
Date: Sat, 26 Nov 2005 20:44:39 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: What are the general causes of frozen system?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to help the bcm43xx project develop a driver for the 
Broadcom 43xx wireless chips, using my Linksys WPC54G card. 
Unfortunately, since the group got far enough to turn on RX DMA, my 
system has frozen whenever I load the driver. TX DMA was OK. It seems to 
correlate with the receipt of a beacon from my AP, but that cannot be 
proven. When the freeze happens, I cannot do anything more and have to 
power the system off.

What should I consider as a cause of the freeze? I have reviewed the 
code and do not find any obvious out-of-bounds memory references. I have 
tried various 'printk' statements, but none of them in the bottom-half 
interrupt routine make it to the logs. Are there any tricks that I 
should try?

Thanks,

Larry
