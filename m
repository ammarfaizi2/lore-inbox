Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751991AbWISOHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbWISOHI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 10:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbWISOHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 10:07:08 -0400
Received: from bay0-omc1-s28.bay0.hotmail.com ([65.54.246.100]:15560 "EHLO
	bay0-omc1-s28.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1751987AbWISOHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 10:07:03 -0400
Message-ID: <BAY12-F45193411A7430CB6EC55DCE220@phx.gbl>
X-Originating-IP: [61.15.223.40]
X-Originating-Email: [kylewong1974@hotmail.com]
From: "Kyle Wong" <kylewong1974@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc7 boot only with acpi=off
Date: Tue, 19 Sep 2006 22:07:00 +0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 19 Sep 2006 14:07:02.0757 (UTC) FILETIME=[E1734950:01C6DBF4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My new Intel E6300 with Intel DQ965GF motherboard does not boot 2.6.18-rc7, 
it just freeze at:
...........
...........
PCI: Using MMConfig at f0000000
ACPI: Interpeter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0[ (0000:00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0

then nothing more. It boots with "acpi=off" option, but it will lose one 
core and EIST! Fedora 5 stock kernel 2.6.15.x also have the same behavier.

The motherboard is already updated with latest BIOS.

Vanilla kernel 2.6.17.13 boot well without the "acpi=off" option.

Please cc me if possible. Thank you

Kyle

_________________________________________________________________
Get 10Mb extra storage for MSN Hotmail. Subscribe Now! 
http://join.msn.com/?pgmarket=en-hk

