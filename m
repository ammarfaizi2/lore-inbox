Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTLHS6c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTLHS6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:58:32 -0500
Received: from web41306.mail.yahoo.com ([66.218.93.55]:47442 "HELO
	web41306.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261799AbTLHS63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 13:58:29 -0500
Message-ID: <20031208185822.96788.qmail@web41306.mail.yahoo.com>
Date: Mon, 8 Dec 2003 10:58:22 -0800 (PST)
From: Jing Xu <xujing_cn2001@yahoo.com>
Subject: irq again
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, guys,

I have been stuct on this problem for a long time. Any
suggestion on this will be highly appreciated.

I'm running linux 2.4.20 and rtai 24.1.11. My linux
kernel module needs to use IRQ 9 10 11 for AGP graphic
card, sound card and PCI-Dio24 IO card. These irqs are
also shared by USB controllers. My module hangs when
it tries to request one of the above irqs that is used
by USB keyboard. 

I am using DELL machine, and its bios cannot reserve
irq's.

I also tried to set boot paramter "pci=irqmask=0xf1ef"
to reserve irqs 9 10 11 4 for my driver, and it hasn't
had any effect - those irqs are still used by usb
controllers on initialization. 

How to solve this irq confliction problem?

Thanks in advance,

jing

__________________________________
Do you Yahoo!?
New Yahoo! Photos - easier uploading and sharing.
http://photos.yahoo.com/
