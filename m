Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbUDAM1w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 07:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbUDAM1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 07:27:52 -0500
Received: from qfep05.superonline.com ([212.252.122.161]:20728 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S262881AbUDAM1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 07:27:49 -0500
Message-ID: <406C0A14.6060302@superonline.com>
Date: Thu, 01 Apr 2004 15:24:52 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [BKPATCH] ACPI for 2.4
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Hi Marcelo, please do a
 >
 > 	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.4.26
 >
 > thanks,
 > -Len
 >
 > ps. a plain patch is also available here:
 > 
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.26/acpi-20040326-2.4.26.diff.gz
 >
 > This will update the following files:
 >
 >  arch/i386/kernel/acpi.c      |    4 +++
 >  arch/i386/kernel/io_apic.c   |    6 ++++-
 >  arch/x86_64/kernel/io_apic.c |    6 ++++-
 >  drivers/acpi/bus.c           |    5 ++++
 >  drivers/acpi/pci_irq.c       |   35 +++++++++++++++++--------------
 >  include/asm-i386/acpi.h      |    9 -------
 >  include/asm-i386/system.h    |    5 ----
 >  7 files changed, 40 insertions(+), 30 deletions(-)
 >
 > through these ChangeSets:
 >
 > <len.brown@intel.com> (04/04/01 1.1063.46.95)
 >    [ACPI] Restore PIC-mode SCI default to Level Trigger (David Shaohua
 > Li)
 >    http://bugme.osdl.org/show_bug.cgi?id=2382
 >
 > <len.brown@intel.com> (04/04/01 1.1063.46.94)
 >    [ACPI] PCI bridge interrupt fix (David Shaohua Li)
 >    http://bugzilla.kernel.org/show_bug.cgi?id=2409
 >
 > <len.brown@intel.com> (04/04/01 1.1063.46.93)
 >    [ACPI] delete extraneous IRQ->pin mappings below IRQ 16
 >    http://bugzilla.kernel.org/show_bug.cgi?id=2408
 >
 > <len.brown@intel.com> (04/03/30 1.1063.46.92)
 >    [ACPI] allow building ACPI w/ CMPXCHG when CONFIG_M386=y
 >    http://bugzilla.kernel.org/show_bug.cgi?id=2391


This fixed the issue I reported about the power button not
functioning in 26-rc1.

Thanks & regards;
Özkan Sezer

