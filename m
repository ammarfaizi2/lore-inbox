Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbVKWUZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVKWUZI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVKWUZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:25:07 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:22191 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S932323AbVKWUZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:25:02 -0500
Message-ID: <4384CFCD.9010304@lanl.gov>
Date: Wed, 23 Nov 2005 13:23:41 -0700
From: Ronald G Minnich <rminnich@lanl.gov>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: yhlu <yinghailu@gmail.com>
CC: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linuxbios@openbios.org,
       yhlu <yhlu.kernel@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [LinuxBIOS] x86_64: apic id lift patch
References: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com>	 <20051121220605.GD20775@brahms.suse.de> <43849FA5.4020201@lanl.gov> <2ea3fae10511230919l4d9829d8j3ce5d820b74074d1@mail.gmail.com>
In-Reply-To: <2ea3fae10511230919l4d9829d8j3ce5d820b74074d1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yhlu wrote:
> sth about SRAT in LinuxBIOS,  I have put SRAT dynamically support in 
> LinuxBIOS, but the whole acpi support still need dsdt, current we only 
> have dsdt for AMD chipset in LB. And we can not have the access the dsdt 
> asl from Nvidia chipset yet...

yeah, this is the great thing about ACPI, it has put us into a whole new 
  era of copyrighted stuff. ACPI tables describe hardware, and are 
copyright bios vendors. The question of which ACPI bits we can use in 
linuxbios is unresolved. AMD has committed to open-source ACPI tables, 
but ... what about companies like nvidia? unknown. And, to add to the 
fun, the mainboard vendors don't own their own ACPI tables -- the BIOS 
vendors do. So the mainboard vendor has their hardware design encoded 
into ACPI tables, which are copyright the bios vendor, not the mainboard 
vendor.

ACPI is a looming problem for all the open-source bios efforts out there.

I don't much like ACPI. It's just another mechanism for hiding 
information and limiting its distribution.

ron
