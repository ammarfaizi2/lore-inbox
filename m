Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWH3AxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWH3AxT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 20:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWH3AxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 20:53:19 -0400
Received: from mailhub1.otago.ac.nz ([139.80.64.218]:12707 "EHLO
	mailhub1.otago.ac.nz") by vger.kernel.org with ESMTP
	id S1750839AbWH3AxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 20:53:18 -0400
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Transfer-Encoding: 7bit
Message-Id: <A2A6BFA6-28FA-4525-8705-31555B5327D2@cs.otago.ac.nz>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel@vger.kernel.org
From: zhiyi huang <hzy@cs.otago.ac.nz>
Subject: Ultra Sparc T1 port
Date: Wed, 30 Aug 2006 12:53:13 +1200
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I am using a Ubuntu port on Ultra Sparc T1.
Linux version 2.6.15-21-sparc64-smp (buildd@artigas) (gcc version  
4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 SMP Fri Apr 21 17:04:05 UTC 2006
I have installed a module in the kernel. It is a RAM device driver.  
When my application calls ioctl on the device (/dev/dsm), I got the  
following log message:

Aug 29 11:13:20 info-sf-03 kernel: [    3.603348] ioctl32(manager: 
18821): Unknown cmd fd(3) cmd(80047f00){00} arg(fffc3934) on /dev/dsm

I check my module and found the control has not reached my module  
yet. I haven't got much clue why it happened and how to fix the  
problem. It works fine on Linux 2.6.8/i386, by the way.
Thanks for help:)

Zhiyi

