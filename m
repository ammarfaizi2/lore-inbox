Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUFQRKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUFQRKd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 13:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUFQRKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 13:10:33 -0400
Received: from lucidpixels.com ([66.45.37.187]:14485 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261181AbUFQRKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 13:10:30 -0400
Date: Thu, 17 Jun 2004 13:10:25 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: ACPI vs. APM - Which is better for desktop and why?
Message-ID: <Pine.LNX.4.60.0406171308080.17891@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have enabled ACPI on my Dell GX1 (Pentium 3/500MHZ) machine and disabled 
APM, however, what are the benefits of using ACPI over APM?

I am using Kernel 2.6.7

I see ACPI eats up an IRQ and does not share it:

$ cat /proc/interrupts
            CPU0
   0:   64997374          XT-PIC  timer
   1:         10          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   5:       2625          XT-PIC  Crystal audio controller
   8:          1          XT-PIC  rtc
   9:          0          XT-PIC  acpi
  10:     277489          XT-PIC  ide2
  11:   11465050          XT-PIC  ide4, ide5, eth0, eth1, eth2, eth3
  12:         58          XT-PIC  i8042
  14:     307536          XT-PIC  ide0
  15:         53          XT-PIC  ide1
NMI:          0
LOC:   65007290
ERR:          0
MIS:          0

