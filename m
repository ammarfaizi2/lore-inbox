Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbTG1MiD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 08:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266622AbTG1MiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 08:38:03 -0400
Received: from aesaeion.com ([65.102.248.137]:42418 "EHLO aesaeion.com")
	by vger.kernel.org with ESMTP id S265531AbTG1MiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 08:38:01 -0400
From: kosh <kosh@aesaeion.com>
Reply-To: kosh@aesaeion.com
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2 usb still failing
Date: Mon, 28 Jul 2003 06:54:14 -0600
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200307280654.15074.kosh@aesaeion.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get
drivers/usb/host/uhci-hcd.c: dc00: host controller halted. very bad

I get that hundreds of times in dmesg and then usb just shuts off. 

I have a VIA KT333 chipset and I have ACPI and APIC enabled on it which works 
fine under 2.4.x kernels. So far this problem has existed since I reported it   
http://www.cs.helsinki.fi/linux/linux-kernel/2003-02/0727.html with the 2.5 
series kernels.One of the differences between the previous messages I have 
sennt and this one is that usb shuts off after about 20 seconds or so after I 
start kde.
