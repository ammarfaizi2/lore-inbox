Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTIXNYn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 09:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbTIXNYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 09:24:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:40690 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261352AbTIXNYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 09:24:41 -0400
X-KENId: 00001511KEN019B37E1
X-KENRelayed: 00001511KEN019B37E1@PCDR800
Date: Wed, 24 Sep 2003 15:18:13 +0200
From: "Christoph Baumann" <cb@sorcus.com>
Subject: mysterious prblem with IO memory
To: <linux-kernel@vger.kernel.org>
Reply-To: "Christoph Baumann" <cb@sorcus.com>
Message-Id: <004b01c3829e$4fe29980$2265a8c0@dirtyentw>
Mime-Version: 1.0
Content-Type: text/plain;
   charset="iso-8859-1"
X-Priority: 3
Organization: SORCUS Computer GmbH
Content-Transfer-Encoding: 7bit
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

developing a driver (currently with a vanilla 2.4.20 kernel) for a PCI
card i encountered a mysterious behaviour. I get the IO addresses from
the card configuration space and use ioremap_nocache to get virtual
addresses for usage with write[bwl]. This works to some extend (the card
behaves as expected). But then at some random moment i get error
messages about dereferencing a NULL pointer and severe crashes
afterwards. When i put a printk("%p\n",address) before each write[bwl]
everything is fine (appart from lots of log entries). I also tried wmb()
after the write commands which didn't help. Any idea?

Mit freundlichen Gruessen / Best regards
Dipl.-Phys. Christoph Baumann
---
SORCUS Computer GmbH
Im Breitspiel 11 c
D-69126 Heidelberg

Tel.: +49(0)6221/3206-0
Fax: +49(0)6221/3206-66

