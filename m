Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268396AbTBYWmQ>; Tue, 25 Feb 2003 17:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268383AbTBYWlA>; Tue, 25 Feb 2003 17:41:00 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:41637 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S268354AbTBYWi0>;
	Tue, 25 Feb 2003 17:38:26 -0500
Subject: weird interrupt sharing between cpu's
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1046213338.980.1.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 25 Feb 2003 23:48:58 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is it correct that cpu1 don't have any interrupts in timer? Or anything
else..?

Regards,
Stian


chevrolet:~# cat /proc/interrupts 
           CPU0       CPU1       
  0:    5449292          0    IO-APIC-edge  timer
  1:      22650          0    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          4          0    IO-APIC-edge  rtc
  9:      29738          0   IO-APIC-level  acpi, uhci-hcd, uhci-hcd,
uhci-hcd
 12:      64723          0    IO-APIC-edge  i8042
 14:         21          0    IO-APIC-edge  ide0
 17:      43552          1   IO-APIC-level  aic7xxx, EMU10K1
 18:        311          1   IO-APIC-level  aic7xxx, Ricoh Co Ltd
RL5c476 II
 19:      29533          1   IO-APIC-level  Ricoh Co Ltd RL5c476 II
(#2), eth0
NMI:          0          0 
LOC:    5449580    5449579 
ERR:          0
MIS:          0
chevrolet:~# 


