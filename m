Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbTLFWUi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 17:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265254AbTLFWUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 17:20:38 -0500
Received: from burp.tkv.asdf.org ([212.16.99.49]:8331 "EHLO burp.tkv.asdf.org")
	by vger.kernel.org with ESMTP id S264233AbTLFWUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 17:20:13 -0500
Date: Sun, 7 Dec 2003 00:19:53 +0200
Message-Id: <200312062219.hB6MJrjH001892@burp.tkv.asdf.org>
From: Markku Savela <msa@burp.tkv.asdf.org>
To: zwane@arm.linux.org.uk
CC: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
In-reply-to: <Pine.LNX.4.58.0312061701260.1758@montezuma.fsmlabs.com> (message
	from Zwane Mwaikambo on Sat, 6 Dec 2003 17:01:47 -0500 (EST))
Subject: Re: 2.6.0-test11, TSC cannot be used as a timesource.
References: <200312061603.hB6G3CrG012634@burp.tkv.asdf.org>
 <Pine.LNX.4.58.0312061253010.10548@montezuma.fsmlabs.com>
 <200312062056.hB6Kuh0D001004@burp.tkv.asdf.org> <200312061652.59880.dtor_core@ameritech.net> <Pine.LNX.4.58.0312061701260.1758@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes cat /proc/interrupts might also give some sort of rough indication.

cat /proc/interrupts
           CPU0
  0:    6713992    IO-APIC-edge  timer
  1:       9451    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          4    IO-APIC-edge  rtc
 12:      19373    IO-APIC-edge  i8042
 14:      38987    IO-APIC-edge  ide0
 15:         10    IO-APIC-edge  ide1
 17:      16753   IO-APIC-level  eth0
 18:          0   IO-APIC-level  SiS SI7012
 20:          0   IO-APIC-level  acpi
 23:          0   IO-APIC-level  ehci_hcd
NMI:          0
LOC:    6721795
ERR:          0
MIS:          0
uptime
 00:18:43 up  1:52,  5 users,  load average: 0.00, 0.01, 0.00
