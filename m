Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbUACSps (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 13:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbUACSps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 13:45:48 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:30482 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263777AbUACSpp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 13:45:45 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0 and hyperthreading
Date: Sat, 03 Jan 2004 13:45:52 -0500
Organization: TMR Associates, Inc
Message-ID: <bt71ub$cfr$1@gatekeeper.tmr.com>
References: <20031229214508.GG916@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1073154827 12795 192.168.12.10 (3 Jan 2004 18:33:47 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20031229214508.GG916@mail.muni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek wrote:
> Hello,
> 
> is it possible to use Hyperthreading on the processor that supports
> hypperthreading but motherboard has no idea about SMP?
> 
> I have in dmesg:
> 238MB LOWMEM available.
> found SMP MP-table at 000f63f0
> hm, page 000f6000 reserved twice.
> hm, page 000f7000 reserved twice.
> hm, page 0009f000 reserved twice.
> hm, page 000a0000 reserved twice.
> On node 0 totalpages: 61152
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 57056 pages, LIFO batch:13
>   HighMem zone: 0 pages, LIFO batch:1
> DMI present.
> ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6420
> ACPI: RSDT (v001 PTLTD  Montara  0x06040000  LTP 0x00000000) @ 0x0eee5e05
> ACPI: FADT (v001 Acer   Yuhina   0x06040000 PTL  0x00000001) @ 0x0eeeaed2
> ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x0eeeafd8
> ACPI: DSDT (v001   ANNI   Yuhina 0x06040000 MSFT 0x0100000e) @ 0x00000000
> Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.
> SMP mptable: bad signature [0x0]!
> BIOS bug, MP table errors detected!...
> ... disabling SMP support. (tell your hw vendor)

You *may* be able to change from MPS 1.4 to 1.1 in the BIOS. Hard to 
believe that a m/b which knows about HT doesn't know about SMP, but it 
certainly could be buggy.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
