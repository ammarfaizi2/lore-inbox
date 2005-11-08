Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbVKHPsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbVKHPsr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 10:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbVKHPsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 10:48:47 -0500
Received: from netzweb.gamper-media.ch ([157.161.128.137]:8979 "EHLO
	ns1.netzweb.ch") by vger.kernel.org with ESMTP id S965065AbVKHPsq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 10:48:46 -0500
From: "Miro Dietiker, MD Systems" <info@md-systems.ch>
To: <linux-kernel@vger.kernel.org>
Subject: Compiling kernel for amd 8131 chipset
Date: Tue, 8 Nov 2005 16:48:34 +0100
Organization: MD Systems
Message-ID: <026601c5e47b$e09d9060$4001a8c0@MDSYSPORT>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there

I've got a Tyan 2891 Barebone here and tried to compile kernel with
support for AMD 8131 PCI-X Controller
(Since via this controller a network-chip bcm5704 is connected on-board)

Link to chipset overview:
http://www.amd.com/us-en/Processors/TechnicalResources/0,,30_182_871_903
4%5E9504,00.html
Link to patch:
http://cdrom.amd.com/21860/updates/opteron_drivers/linux/amdshpc-1.1.9.t
ar.gz
This patch is described to be for 2.6.11.9 but I'm not able to compile
support for my 8131 (and sure the NIC as effect)
I tried multiple Kernels (such as 2.6.14, 2.6.12, 2.6.11.9)

My last try (2.6.14) resulted in the error message:
insmod amdshpc.ko
amdshpc: Unknown symbol reparent_to_init
insmod: error inserting '/lib/modules/2.6.14/...': -1 Unknown symbol in
module

I couldn't find any thread about this topic.
Surprisingly if I start "knoppix 3.91 with 2.8.11" the chipset is being
detected (lspci)
 
Do you have any idea for doing that?

I don't know what to try next... would be great :)

+-------------------------------+  +-------------------------------+
| Miro Dietiker                 |  | MD Systems Miro Dietiker      |
| Dipl. Ing. FH Elektrotechnik  |  | Alte Zürcherstrasse 10        |
|                               |  | 8903 Birmensdorf              |
|                               |  |                               |
| Mobile:   +41 (0)78 707 30 10 |  | Geschäft: +41 (0)43 344 03 56 |
|                               |  | Fax:      +41 (0)43 344 03 57 |
| m.dietiker@md-systems.ch      |  | info@md-systems.ch            |
|                               |  |             www.md-systems.ch |
+-------------------------------+  +-------------------------------+


