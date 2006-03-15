Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWCOK5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWCOK5C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 05:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWCOK5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 05:57:01 -0500
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:11667 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750824AbWCOK5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 05:57:00 -0500
Date: Wed, 15 Mar 2006 05:50:39 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: More than 8 CPUs detected and CONFIG_X86_PC cannot handle
  it on 2.6.16-rc6
To: Krzysztof Oledzki <olel@ans.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ashok Raj <ashok.raj@intel.com>
Message-ID: <200603150553_MC3-1-BAB1-7C5A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <Pine.LNX.4.64.0603120256480.14567@bizon.gios.gov.pl>

On Sun, 12 Mar 2006 03:04:40 +0100, Krzysztof Oledzki wrote:

> After upgrading to 2.6.16-rc6 I noticed this strange message:
> 
> More than 8 CPUs detected and CONFIG_X86_PC cannot handle it.
> Use CONFIG_X86_GENERICARCH or CONFIG_X86_BIGSMP.
> 
> This is a Dell PowerEdge SC1425 with two P4 Xeons with HT enabled (so with 
> totoal of 4 logical CPUs).

In a later message, you wrote:

> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> Processor #0 15:4 APIC version 20
> ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
> Processor #6 15:4 APIC version 20
             ^
> ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
> Processor #1 15:4 APIC version 20
> ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
> Processor #7 15:4 APIC version 20
             ^

What processor numbers did you get on 2.6.15.x?
Does /proc/cpuinfo show all four CPUs?
If you start four CPU-hungry processes, do all four show 100% utilization in top(1)?


-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"

