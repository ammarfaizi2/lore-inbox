Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbTI3JjO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 05:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbTI3JjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 05:39:13 -0400
Received: from main.gmane.org ([80.91.224.249]:39317 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261263AbTI3JjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 05:39:12 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Schwarz <usenet.2117@andreas-s.net>
Subject: ERR in /proc/interrupts
Date: Tue, 30 Sep 2003 09:39:10 +0000 (UTC)
Message-ID: <slrnbnijq7.41m.usenet.2117@home.andreas-s.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-TCPA-ist-scheisse: yes
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a very high ERR count in /proc/interrupts. If I move my USB mouse
the number increases.

What does ERR mean? Nothing good, I suppose?

Kernel: 2.6.0-test6-mm1

/proc/interrupts:
====================================================

           CPU0       
  0:    1924793          XT-PIC  timer
  1:       9571          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:       1561          XT-PIC  ohci-hcd, eth1
  8:          2          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:          0          XT-PIC  ehci_hcd, ohci-hcd, eth0
 11:      31910          XT-PIC  EMU10K1, uhci-hcd, uhci-hcd
 14:      12483          XT-PIC  ide0
 15:         41          XT-PIC  ide1
NMI:          0 
LOC:    1924399 
ERR:      15255
MIS:          0

-- 
AVR-Tutorial, über 350 Links
Forum für AVRGCC und MSPGCC
-> http://www.mikrocontroller.net

