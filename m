Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVBNPVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVBNPVV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 10:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVBNPVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 10:21:21 -0500
Received: from [202.125.86.130] ([202.125.86.130]:44702 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261445AbVBNPVR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 10:21:17 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: How to get the maximum output from dmesg command
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Mon, 14 Feb 2005 20:55:35 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB3481134E2AE@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to get the maximum output from dmesg command
Thread-Index: AcUSqW4Lm/OUjfNlS4K9vpEUAiZTBA==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Cc: <jjoy@novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

How to get maximum output from dmesg command? 
I am unable to see all my debug messages after loading my driver. 
I think there is a restriction in displaying the dmesg output. 
I saw in printk.c file under source directory. There I found LOG_BUF_LEN
is 16384.
But I am unable to see not more that 300 to 400 lines of code from
dmesg. 
If I modify in the printk.c file then I get more lines of code from
dmesg command!!!

As var/log/messages is the source of dmesg command, I made a copy of
var/log/messages assuming that I will be getting the complete driver
trace in it. But a part of the messages that are at the initialization
of our driver are not seen. 

How can I get maximum lines of output from the dmesg command? 
I am using Red Hat 7.3 with 2.4.18-3 kernel version. 
Can anybody help in this regard?

Thanks in advance.
Regards,
Srinivas G

