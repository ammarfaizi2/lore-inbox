Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284609AbRLETW1>; Wed, 5 Dec 2001 14:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284588AbRLETWR>; Wed, 5 Dec 2001 14:22:17 -0500
Received: from pc26.tromso2.avidi.online.no ([148.122.16.26]:7182 "EHLO
	shogun.thule.no") by vger.kernel.org with ESMTP id <S284586AbRLETWF>;
	Wed, 5 Dec 2001 14:22:05 -0500
From: "Troels Walsted Hansen" <troels@thule.no>
To: linux-kernel@vger.kernel.org
Subject: VIA acknowledges North Bridge bug (AKA Linux Kernel with Athlon optimizations bug)
Date: Wed, 5 Dec 2001 20:21:57 +0100
Message-ID: <005b01c17dc2$1c244130$0300000a@samurai>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3311
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remember the pci_fixup_via_athlon_bug() (AKA "Athlon bug stomper")
function which went into kernel 2.4.14 after much discussion?

Apparently the mysterious register 55 in the Northbridge controls a
buggy Memory Write Queue timer. They finally acknowledged the problem
when Nvidia drivers and Windows XP started pushing the hardware enough
to trigger the bug...

http://bbs.pcstats.com/viahardware/messageview.cfm?catid=19&threadid=863
8

-- 
Troels Walsted Hansen


