Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbUCDNTZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 08:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbUCDNTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 08:19:25 -0500
Received: from mail3a.westend.com ([212.117.79.77]:31447 "EHLO
	mail3a1.westend.com") by vger.kernel.org with ESMTP id S261883AbUCDNTS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 08:19:18 -0500
Date: Thu, 4 Mar 2004 14:19:15 +0100
From: Christian Hammers <ch@westend.com>
To: linux-kernel@vger.kernel.org
Subject: Server suddenly freezes but awakes upon SysRq!?
Message-ID: <20040304131915.GA15713@westend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

We have some problems with a server that started to suddenly freeze
every now and then which means that it does react to ping and tcp
connects but does not allow a login nor returns the shell or does syslog
write anything to disc or network.

Funnily it always immediately awakes when we presses 'AltGr+SysGr+h'
although a login on the console did not work before.

What could be the cause of this "sleep" mode if a sysrq ends it?
We noticed that at least 1-2 freezes occured right after accessing the
external usb2.0 backup harddrive.

The server is a dual-p3 with a 3ware ide-scsi RAID and very low load as
postfix+apache server.

bye,

-christian-

Some bits of the configuration:

...
CONFIG_MPENTIUMIII=y
...
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_HIGHIO=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_NR_CPUS=32
# CONFIG_X86_NUMA is not set
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y
CONFIG_HAVE_DEC_LOCK=y
#
# General setup
#
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y
...
# CONFIG_ACPI is not set
CONFIG_ACPI_BOOT=y
...
CONFIG_PNP=y
CONFIG_ISAPNP=m
...
CONFIG_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_LOG_BUF_SHIFT=0

-- 
Christian Hammers             WESTEND GmbH  |  Internet-Business-Provider
Technik                       CISCO Systems Partner - Authorized Reseller
                              Lütticher Straße 10      Tel 0241/701333-11
ch@westend.com                D-52064 Aachen              Fax 0241/911879

