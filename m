Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268593AbUIGU3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268593AbUIGU3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 16:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268193AbUIGU2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 16:28:07 -0400
Received: from odin.allegientsystems.com ([208.251.178.227]:4370 "EHLO
	pegasus.lawaudit.com") by vger.kernel.org with ESMTP
	id S268532AbUIGUXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 16:23:40 -0400
Message-ID: <413E18CB.7020305@optonline.net>
Date: Tue, 07 Sep 2004 16:23:39 -0400
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040806
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: 2.6.9-rc1-mm4
References: <20040907020831.62390588.akpm@osdl.org> <200409072201.55025.l_allegrucci@yahoo.it>
In-Reply-To: <200409072201.55025.l_allegrucci@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo Allegrucci wrote:
> On Tuesday 07 September 2004 11:08, Andrew Morton wrote:
> 
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6
>>.9-rc1-mm4/
> 
> 
> My PS/2 keyboard doesn't work, I tried "pci=routeirq" but it didn't help.
> 
> Sep  7 21:39:00 odyssey kernel: i8042: ACPI  [PS2K] at I/O 0x0, 0x0, irq 1
> Sep  7 21:39:00 odyssey kernel: i8042: ACPI  [PS2M] at irq 12
> Sep  7 21:39:00 odyssey kernel: i8042.c: Can't read CTR while initializing 
> i8042.
> 

Try i8042.noacpi on the kernel command line

Seems Bjorn's patch needs to be reworked to ignore obviously broken BIOS 
return values
