Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbTIPLKB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 07:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTIPLKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 07:10:00 -0400
Received: from [203.124.210.99] ([203.124.210.99]:57802 "EHLO
	rocklines.oyeindia.com") by vger.kernel.org with ESMTP
	id S261841AbTIPLJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 07:09:58 -0400
From: "msrinath" <msrinath@bplitl.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel NMI error
Date: Tue, 16 Sep 2003 16:43:55 +0530
Message-ID: <004c01c37c43$9ecaf4e0$1d03000a@srinath>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
X-Information: Please contact the ISP for more information
X-Kaspersky: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Everybody,

Can anyone help me on this?

Recently one of our servers running RedHat linux 7.2 with 2.4.7-10 SMP
kernel generated the following log and the system rebooted. This system has
2 CPUs.

Sep 16 01:34:24 cbesc ftpd[30753]: FTP LOGIN FROM 16.128.157.7
[16.128.157.7], scuser
Sep 16 01:36:48 cbesc ftpd[30753]: FTP session closed
Sep 16 01:54:30 cbesc kernel: Uhhuh. NMI received for unknown reason 35.
Sep 16 01:54:30 cbesc kernel: Dazed and confused, but trying to continue
Sep 16 01:54:30 cbesc kernel: Do you have a strange power saving mode
enabled?
Sep 16 01:54:30 cbesc kernel: eth0: card reports no resources.
Sep 16 01:58:09 cbesc syslogd 1.4.1: restart.
Sep 16 01:58:09 cbesc syslog: syslogd startup succeeded

This is the first time we have faced this problem. The ethernet card used is
intel eepro 100. The details are shown below.

Sep 16 07:33:53 cbesc kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
Sep 16 07:33:53 cbesc kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17
Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Sep 16 07:33:53 cbesc kernel: eth0: Intel Corporation 82557 [Ethernet Pro
100], 00:A0:C9:A0:B7:71, IRQ 16.
Sep 16 07:33:53 cbesc kernel:   Receiver lock-up bug exists -- enabling
work-around.
Sep 16 07:33:53 cbesc kernel:   Board assembly 668081-004, Physical
connectors present: RJ45
Sep 16 07:33:53 cbesc kernel:   Primary interface chip i82555 PHY #1.
Sep 16 07:33:54 cbesc kernel:   General self-test: passed.
Sep 16 07:33:54 cbesc kernel:   Serial sub-system self-test: passed.
Sep 16 07:33:54 cbesc kernel:   Internal registers self-test: passed.
Sep 16 07:33:54 cbesc kernel:   ROM checksum self-test: passed (0x3c15c8f1).
Sep 16 07:33:54 cbesc kernel:   Receiver lock-up workaround activated.


Please let me know why this happened and whether it indicates any hardware
problem in the system.

Thanks & Regards,

- Srinath.


-- 
This message has been scanned for viruses and
dangerous content by Kaspersky on bpl Server, and is
believed to be clean.
bpl www.kaspersky.com
.

