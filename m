Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbULOAnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbULOAnv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbULOAl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:41:28 -0500
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:53819 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261729AbULOAkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 19:40:06 -0500
Message-ID: <41BF87E0.3030505@blueyonder.co.uk>
Date: Wed, 15 Dec 2004 00:40:00 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Dec 2004 00:40:31.0123 (UTC) FILETIME=[AE2CAE30:01C4E23E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same failure in previous RT V0.7-32 builds on x86_64, SuSE 9.2 gcc 
version 3.3.4 (pre 3.3.5 20040809)

   CC      arch/x86_64/kernel/../../i386/mach-default/topology.o
   LD      arch/x86_64/kernel/bootflag.o
   CC      arch/x86_64/kernel/e820.o
In file included from include/asm/dma.h:13,
                  from include/linux/bootmem.h:8,
                  from arch/x86_64/kernel/e820.c:10:
include/asm/io.h: In function `memset_io':
include/asm/io.h:265: warning: implicit declaration of function `memset'
include/asm/io.h:265: warning: return makes pointer from integer without 
a cast
   CC      arch/x86_64/kernel/reboot.o
   LD      arch/x86_64/kernel/quirks.o
   CC      arch/x86_64/kernel/semaphore.o
   CC      arch/x86_64/kernel/mce.o
   CC      arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/main.o
   CC      arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/if.o
   CC      arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/generic.o
   CC      arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/state.o
   CC      arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/amd.o
   CC      arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/cyrix.o
   CC      arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/centaur.o
   LD      arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/built-in.o
   CC      arch/x86_64/kernel/acpi/../../../i386/kernel/acpi/boot.o
In file included from arch/i386/kernel/acpi/boot.c:30:
include/linux/irq.h:80: error: parse error before "cycles_t"
include/linux/irq.h:80: warning: no semicolon at end of struct or union
include/linux/irq.h:82: error: parse error before '}' token
include/linux/irq.h:82: warning: type defaults to `int' in declaration 
of `irq_desc_t'
include/linux/irq.h:84: error: parse error before "irq_desc"
include/linux/irq.h:84: warning: type defaults to `int' in declaration 
of `irq_desc'
include/linux/irq.h:84: warning: data definition has no type or storage 
class
In file included from arch/i386/kernel/acpi/boot.c:30:
include/linux/irq.h:99: error: parse error before "irq_desc_t"
include/linux/irq.h:99: warning: function declaration isn't a prototype
include/linux/irq.h:100: error: parse error before "irq_desc_t"
include/linux/irq.h:100: warning: function declaration isn't a prototype
make[2]: *** [arch/x86_64/kernel/acpi/../../../i386/kernel/acpi/boot.o] 
Error 1
make[1]: *** [arch/x86_64/kernel/acpi] Error 2
make: *** [arch/x86_64/kernel] Error 2

Regards
Sid.
-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====
