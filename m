Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbUBIJJF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 04:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbUBIJJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 04:09:05 -0500
Received: from ns.suse.de ([195.135.220.2]:34014 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264437AbUBIJJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 04:09:01 -0500
Date: Mon, 9 Feb 2004 10:09:00 +0100
From: Olaf Hering <olh@suse.de>
To: Len Brown <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BKPATCH] ACPI for 2.6
Message-ID: <20040209090900.GA30625@suse.de>
References: <1076145027.8682.34.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1076145027.8682.34.camel@dhcppc4>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Feb 07, Len Brown wrote:

> Hi Linus, please do a 
> 
> 	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.6.3
> 
> 	ACPI cpufreq related updates from Dominik, Asus and Toshiba
> 	model specific updates from Karol and John, misc IA64
> 	ACPI tweaks from Jes Sorensen etc.  All but Toshiba
> 	and Asus have been through -mm.
> 
> thanks,
> -Len
> 
> ps. a plain patch is also available here:
> ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.3/acpi-20040116-2.6.3.diff.gz

>  arch/ia64/kernel/acpi.c             |   22 

Len,

this file uses now NR_MEMBLKS, which is undefined. Do you have a patch
to fix it?

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
