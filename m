Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272071AbTG1CEV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272404AbTG1CDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 22:03:10 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:33290 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S272071AbTG1CCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 22:02:10 -0400
From: Marino Fernandez <mjferna@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Memory runs out fast with 2.6.0-test2 (and test1)
Date: Sun, 27 Jul 2003 21:17:23 -0500
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307272117.23398.mjferna@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everything works OK in my system... my only gripe is that I run out of memory 
quickly. I have a Fujitsu C-7651 Lifebook laptop, Pentium III, 512 Mb Ram, 
300 Mb swap.

When I start up (with KDE) I've alredy used 300 megs of ram. The if I open 
mozilla, and view some phostos with kuickshow, thats it, I use 700 Megs of 
physical and virtual memory...

Looking at ps aux shows that 5% goes to each of the 5 mozilla processes, 3% 
for this, 2% for that... It is all accounted for in different ways. It is 
just that running under 2.4.21, with the same programs I very rarely use my 
swap memory, let alone use all my physical and swap memory.

PS
I had the same issue with test1.

PPS
Could it be that I am doing something stupid when I configure the kernel... 
This is what I have in my config file.. may be config_nohighmem?:

# Processor type and features
#
CONFIG_X86_PC=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
CONFIG_MATH_EMULATION=y
CONFIG_MTRR=y



