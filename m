Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262731AbTCPTgd>; Sun, 16 Mar 2003 14:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262733AbTCPTgc>; Sun, 16 Mar 2003 14:36:32 -0500
Received: from franka.aracnet.com ([216.99.193.44]:40636 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262731AbTCPTgc>; Sun, 16 Mar 2003 14:36:32 -0500
Date: Sun, 16 Mar 2003 11:44:06 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.5.64-mm8: link error with CONFIG_NUMA and !CONFIG_SMP
Message-ID: <88340000.1047843845@[10.10.2.4]>
In-Reply-To: <86910000.1047843162@[10.10.2.4]>
References: <20030316024239.484f8bda.akpm@digeo.com> <20030316191012.GG10253@fs.tum.de> <86910000.1047843162@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I get many errors at the final linking when compiling a kernel with
>> CONFIG_NUMA enabled but CONFIG_SMP disabled:
> 
> Well don't do that then ;-)
> 
>  # Common NUMA Features
> config NUMA
>         bool "Numa Memory Allocation Support"
>         depends on (HIGHMEM64G && (X86_NUMAQ || (X86_SUMMIT && ACPI && !ACPI_HT_
> ONLY)))
> 
> I guess SMP should be added to the dependencies, but the whole things 
> getting a little twisted. Let me try and sort it out properly this afternoon.

Ah ... maybe you were referring to the bit when Andy was going to get this
working on a standard PC for distros (actually, they still have SMP images,
I think ... but still). Not quite finished yet, and Andy's off on vacation ;-)
Avoid that combo for now ... will fix soon.

M.

