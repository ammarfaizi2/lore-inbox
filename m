Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264240AbTLEQBQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 11:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbTLEQBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 11:01:16 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:41602
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264256AbTLEQBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 11:01:13 -0500
Date: Fri, 5 Dec 2003 11:00:11 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Paul Rolland <rol@witbe.net>
cc: linux-smp@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: WARNING: MP table in the EBDA can be UNSAFE
In-Reply-To: <200312051518.hB5FIQD29335@tag.witbe.net>
Message-ID: <Pine.LNX.4.58.0312051053481.10913@montezuma.fsmlabs.com>
References: <200312051518.hB5FIQD29335@tag.witbe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Dec 2003, Paul Rolland wrote:

> Our Linux, running on an IBM X-Series 445, says :
> (excerpt from dmesg) :
>
> found SMP MP-table at 0009dd40
> hm, page 0009d000 reserved twice.
> hm, page 0009e000 reserved twice.
> hm, page 0009e000 reserved twice.
> hm, page 0009f000 reserved twice.
> WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems!

This bit is ok and can be safely ignored.

> LAPIC (acpi_id[0x0000] id[0x0] enabled[1])
> CPU 0 (0x0000) enabledProcessor #0 Pentium 4(tm) XEON(tm) APIC version 16
>
> LAPIC (acpi_id[0x0001] id[0x12] enabled[1])
> CPU 1 (0x1200) enabled<4>Processor #18 INVALID - (Max ID: 16).
> LAPIC (acpi_id[0x0002] id[0x20] enabled[1])
> CPU 1 (0x2000) enabled<4>Processor #32 INVALID - (Max ID: 16).
> LAPIC (acpi_id[0x0003] id[0x32] enabled[1])
> CPU 1 (0x3200) enabled<4>Processor #50 INVALID - (Max ID: 16).
>
> Is there any known solution to re-enable the CPU 1, CPU 2 and CPU 3 ?
>
> Is this an IBM bug ?

Did you compile your kernel with the following option?
IBM x440 Summit/EXA support

CONFIG_X86_SUMMIT
