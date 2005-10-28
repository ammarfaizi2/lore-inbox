Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751883AbVJ1WHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbVJ1WHB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 18:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbVJ1WHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 18:07:01 -0400
Received: from sender-01.it.helsinki.fi ([128.214.205.139]:26341 "EHLO
	sender-01.it.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751883AbVJ1WHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 18:07:00 -0400
Date: Sat, 29 Oct 2005 01:06:53 +0300 (EEST)
From: Janne M O Heikkinen <jmoheikk@cc.helsinki.fi>
X-X-Sender: jmoheikk@rock.it.helsinki.fi
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64: 2.6.14 with NUMA panics at boot
In-Reply-To: <p73vezhtkpy.fsf@verdi.suse.de>
Message-ID: <Pine.OSF.4.61.0510290058420.417368@rock.it.helsinki.fi>
References: <Pine.OSF.4.61.0510282218310.411472@rock.it.helsinki.fi>
 <p73vezhtkpy.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2005, Andi Kleen wrote:

> Janne M O Heikkinen <jmoheikk@cc.helsinki.fi> writes:
>
>> With CONFIG_K8_NUMA I get the following right after boot:
>> PANIC: early exception rip ffffffff8023429f error 0 cr2 0
>> PANIC: early exception rip ffffffff8011893a error 0 cr2 ffffffffff5fd023

> Did earlier kernels work? Please post full log with earlyprintk=vga
> or earlyprintk=serial,ttySx,baud

2.6.13.4 works just fine, this is what I got with earlyprintk=vga:

Loading K-2.6.14
Bootdata ok (command line is auto BOOT_IMAGE=K-2.6.14 ro root=901 
resume=/dev/md0 selinux=0 splash=verbose console=tty0 earlyprintk=vga)
Linux version 2.6.14-smp (jamse@linux) (gcc version 4.0.2) #3 SMP 
PREEMPT Fri Oct 28 20:49:34 EEST 2005one.
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
BIOS-e820: 00000000bfff0000 - 00000000bffff000 (ACPI data)
BIOS-e820: 00000000bffff000 - 00000000c0000000 (ACPI NVS)
BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
SRAT: PXM 0 -> APIC 0 -> CPU 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> CPU 1 -> Node 1
SRAT: Node 0 PXM 0 100000-7fffffff
SRAT: Node 1 PXM 1 80000000-bfffffff
SRAT: Node 1 PXM 1 80000000-13fffffff
SRAT: Node 0 PXM 0 0-7fffffff
Bootmem setup node 0 0000000000000000-000000007fffffff
PANIC: early exception rip ffffffff8023429f error 0 cr2 0
PANIC: early exception rip ffffffff8011893a error 0 cr2 ffffffffff5fd023
