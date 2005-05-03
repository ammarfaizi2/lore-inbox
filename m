Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVECCvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVECCvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 22:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVECCvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 22:51:18 -0400
Received: from 70-57-132-14.albq.qwest.net ([70.57.132.14]:57231 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261320AbVECCvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 22:51:15 -0400
Date: Mon, 2 May 2005 20:53:29 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
cc: Andrew Morton <akpm@osdl.org>, ak@muc.de, Len Brown <len.brown@intel.com>,
       venkatesh.pallipadi@intel.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/1] Added NO_IOAPIC_CHECK in io_apic_get_unique_id()
 for ACPI boot
In-Reply-To: <20050501105434.2B95E42AD7@linux.site>
Message-ID: <Pine.LNX.4.61.0505020715240.12903@montezuma.fsmlabs.com>
References: <20050501105434.2B95E42AD7@linux.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 May 2005 Natalie.Protasevich@unisys.com wrote:

> This patch allows xAPIC systems that don't have serial bus for 
> interrupts delivery to by-pass the check on uniquness of IO-APIC IDs. 
> Some of ES7000's panic failing this unnecessary check. The genapic 
> mechanism has NO_IOAPIC_CHECK flag, which is defined in each subarch. 
> The MP boot utilizes it, but the ACPI boot is missing it.
> 
> Signed-off by: Natalie Protasevich  <Natalie.Protasevich@unisys.com>

Acked-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Thanks Natalie. Andrew although we currently have a lot of patches in 
the same area in your tree and things need settling down, this one looks 
safe to pickup if you'd like to take it in now.
