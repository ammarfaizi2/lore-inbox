Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263335AbUDYUNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbUDYUNZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 16:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbUDYUNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 16:13:25 -0400
Received: from mail3.absamail.co.za ([196.35.40.69]:12188 "EHLO absamail.co.za")
	by vger.kernel.org with ESMTP id S263335AbUDYUNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 16:13:23 -0400
Subject: [2.6.6-rc2] ACPI unusable on TP
From: Niel Lambrechts <antispam@absamail.co.za>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1082923946.5356.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 25 Apr 2004 22:12:27 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have ACPI working to a considerable extent in 2.6.5 (I use my own
dsdt). In 2.6.6rc-1/2 and mm1 however, the system refuses to boot. 

There are no messages apart from the 1st "decompressing ..." message,
even with ACPI debug statements on (or pci=noacpi for that matter).

How do I troubleshoot this?

-Niel

PS. I include settings for ACPI and APIC.

Cfg:
IBM Thinkpad R50P
SuSE 9.0 Pro

# Power management options (ACPI, APM)
# ACPI (Advanced Configuration and Power Interface) Support
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_GOOD_APIC=y
# CONFIG_X86_UP_APIC is not set



