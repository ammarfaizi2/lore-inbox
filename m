Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752583AbWKAX4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbWKAX4Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbWKAX4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:56:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3299 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752583AbWKAX4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:56:13 -0500
Date: Wed, 1 Nov 2006 18:55:46 -0500
From: Dave Jones <davej@redhat.com>
To: Stephen Clark <Stephen.Clark@seclark.us>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: fc6 kernel 2.6.18-1.2798 breaks acpi on HP laptop n5430
Message-ID: <20061101235546.GB10577@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Stephen Clark <Stephen.Clark@seclark.us>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <4548DDF4.2030903@seclark.us> <20061101201218.GA4899@martell.zuzino.mipt.ru> <45490EFE.1060608@seclark.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45490EFE.1060608@seclark.us>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 04:17:50PM -0500, Stephen Clark wrote:

 > BIOS-provided physical RAM map:
 >  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 >  BIOS-e820: 000000000009f000 - 0000000000100000 (reserved)
 >  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 >  BIOS-e820: 000000001fff0000 - 000000001ffff000 (ACPI data)
 >  BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 >  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
 > 0MB HIGHMEM available.
 > 511MB LOWMEM available.
 > Using x86 segment limits to approximate NX protection
 > DMI 2.2 present.
 > Using APIC driver default
 > ACPI: PM-Timer IO Port: 0x8008
 > Allocating PCI resources starting at 30000000 (gap: 20000000:dff80000)
 > Detected 850.075 MHz processor.
 > Built 1 zonelists.  Total pages: 131056
 > Kernel command line: ro root=/dev/VolGroup00/LogVol00 lapic nousb 
 > console=ttyS0,38400
 > Local APIC disabled by BIOS -- reenabling.
 > Found and enabled local APIC!

Does it make a difference if you boot with nolapic ?

	Dave

-- 
http://www.codemonkey.org.uk
