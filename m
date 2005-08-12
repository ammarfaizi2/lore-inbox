Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbVHLOzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbVHLOzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 10:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbVHLOzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 10:55:46 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:46395 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S1750985AbVHLOzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 10:55:46 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.96,103,1122847200"; 
   d="scan'208"; a="14002681:sNHT26806072"
Message-ID: <42FCB86C.5040509@fujitsu-siemens.com>
Date: Fri, 12 Aug 2005 16:55:40 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: APIC version and 8-bit APIC IDs
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel> <p73pssj2xdz.fsf@verdi.suse.de> <42FCA23C.7040601@fujitsu-siemens.com> <20050812133248.GN8974@wotan.suse.de> <42FCA97E.5010907@fujitsu-siemens.com>
In-Reply-To: <42FCA97E.5010907@fujitsu-siemens.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

>> How so? The XAPIC version check should work there.
> 
> ACPI: LAPIC (acpi_id[0x11] lapic_id[0x21] enabled)
> Processor #33 15:4 APIC version 16
> ACPI: LAPIC (acpi_id[0x12] lapic_id[0x26] enabled)
> Processor #38 15:4 APIC version 16

Forget it. I have fallen prey to  this line:

	processor.mpc_apicver = 0x10; /* TBD: lapic version */

in arch/x86_64/kernel/mpparse.c.
I am used to get correct answers from Linux :-)

Cheers
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
