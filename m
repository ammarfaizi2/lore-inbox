Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756336AbWK0DEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756336AbWK0DEZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 22:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756337AbWK0DEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 22:04:25 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:50321 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1756298AbWK0DEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 22:04:24 -0500
Message-ID: <456A55B7.5030802@tlinx.org>
Date: Sun, 26 Nov 2006 19:04:23 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: WARNING in 2.6.18.2 (ACPI)  Section mismatch...
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  MODPOST
WARNING: drivers/acpi/processor.o - Section mismatch: reference to 
.init.data: from .text between 'acpi_processor_power_init' (at offset 
0x14de) and 'acpi_processor_power_exit'
  AS      arch/i386/boot/compressed/head.o
----
Turned on APCI and am now getting the above warning.

Did a make clean & remake -- same thing.

Is this important?

Tnx,
Linda

