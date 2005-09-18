Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbVIRNLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbVIRNLR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 09:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVIRNLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 09:11:17 -0400
Received: from 69.50.231.10.ip.nectartech.com ([69.50.231.10]:44959 "EHLO
	newton.ctyme.com") by vger.kernel.org with ESMTP id S1751191AbVIRNLQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 09:11:16 -0400
Message-ID: <432D676F.2040208@perkel.com>
Date: Sun, 18 Sep 2005 06:11:11 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Serious time drift - clock running fast
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-filter-host: newton.ctyme.com - http://www.junkemailfilter.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure what the problem is but it seem kernel related. If it's not - 
please forgive me.

I'm running and AMD Athlon 64 X2 on an Asus board with NVidia chipset. 
The software clock gains several seconds every minute. I'm running the 
2.6.13 kernel. NTPD doesn't help. It sets the time when it starts but I 
suspect the drift is too great for it to lock on. How can setting the 
clock be so hard?

Using these settings:

CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

Falling asleep .... ZZZzzzzzZZZZzzzzzz

Help!


-- 
Marc Perkel - marc@perkel.com

Spam Filter: http://www.junkemailfilter.com
    My Blog: http://marc.perkel.com

