Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbVHLNwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVHLNwB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 09:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVHLNwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 09:52:01 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:42636 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S1751182AbVHLNwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 09:52:00 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.96,103,1122847200"; 
   d="scan'208"; a="13999206:sNHT28975336"
Message-ID: <42FCA97E.5010907@fujitsu-siemens.com>
Date: Fri, 12 Aug 2005 15:51:58 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC version and 8-bit APIC IDs
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel> <p73pssj2xdz.fsf@verdi.suse.de> <42FCA23C.7040601@fujitsu-siemens.com> <20050812133248.GN8974@wotan.suse.de>
In-Reply-To: <20050812133248.GN8974@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>>on the Intel Xeon MP systems, too,
> 
> How so? The XAPIC version check should work there.

ACPI: LAPIC (acpi_id[0x11] lapic_id[0x21] enabled)
Processor #33 15:4 APIC version 16
ACPI: LAPIC (acpi_id[0x12] lapic_id[0x26] enabled)
Processor #38 15:4 APIC version 16

This is a boot message excerpt from one of the "Potomac" systems we 
have. x86_64 kernel without xapic check, therefore the CPUs are 
activated, but they wouldn't be on recent i386.

> I fixed that in the 64bit version already, but not in 32bit yet.
> Yes, the value of the APIC IDs must be used as indicator.

Great.
Regards, Martin


-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
