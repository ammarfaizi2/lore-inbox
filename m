Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWAaDKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWAaDKo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 22:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWAaDKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 22:10:44 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:31128 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1030274AbWAaDKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 22:10:43 -0500
Message-ID: <43DED532.5060407@tlinx.org>
Date: Mon, 30 Jan 2006 19:10:42 -0800
From: "L. A. Walsh" <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: i386 requires x86_64?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generating a new kernel and wanted to delete the unrelated architectures.

Is the i386 supposed to depend on the the x86_64 architecture?

In file included from arch/i386/kernel/acpi/earlyquirk.c:8:
include/asm/pci-direct.h:1:35: asm-x86_64/pci-direct.h: No such file or 
directory
arch/i386/kernel/acpi/earlyquirk.c: In function `check_acpi_pci':
arch/i386/kernel/acpi/earlyquirk.c:34: warning: implicit declaration of 
function `read_pci_config'
make[2]: *** [arch/i386/kernel/acpi/earlyquirk.o] Error 1
make[1]: *** [arch/i386/kernel/acpi] Error 2
make: *** [arch/i386/kernel] Error 2
make: *** Waiting for unfinished jobs....

I'm generating for a pentium-3 based computer.  Should that
include x86_64 bits?

Thanks,
Linda
