Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTKTREe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 12:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbTKTREe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 12:04:34 -0500
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:21658 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S262694AbTKTREc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 12:04:32 -0500
Message-ID: <3FBD0041.2000209@rackable.com>
Date: Thu, 20 Nov 2003 09:56:17 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-rc2 amd64 compile still broken
References: <Pine.LNX.4.44.0311201348060.1383-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0311201348060.1383-100000@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Nov 2003 17:04:29.0757 (UTC) FILETIME=[5C6D0ED0:01C3AF88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> On Wed, 19 Nov 2003, Samuel Flory wrote:
> 
> 
>>   The amd64 compile is still breaking for me.
>>
>>gcc -D__KERNEL__ -I/usr/src/linux-2.4.23-rc2/include -Wall 
>>-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
>>-fomit-frame-pointer -mno-red-zone -mcmodel=kernel -pipe 
>>-fno-reorder-blocks -finline-limit=2000 -fno-strength-reduce 
>>-Wno-sign-compare -fno-asynchronous-unwind-tables    -nostdinc 
>>-iwithprefix include -DKBUILD_BASENAME=pci_x86_64  -c -o pci-x86_64.o 
>>pci-x86_64.c
>>gcc -D__KERNEL__ -I/usr/src/linux-2.4.23-rc2/include -Wall 
>>-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
>>-fomit-frame-pointer -mno-red-zone -mcmodel=kernel -pipe 
>>-fno-reorder-blocks -finline-limit=2000 -fno-strength-reduce 
>>-Wno-sign-compare -fno-asynchronous-unwind-tables    -nostdinc 
>>-iwithprefix include -DKBUILD_BASENAME=pci_pc  -c -o pci-pc.o pci-pc.c
>>pci-pc.c:573: redefinition of `use_acpi_pci'
>>pci-pc.c:30: `use_acpi_pci' previously defined here
>>pci-pc.c:573: warning: `use_acpi_pci' was declared `extern' and later 
>>`static'
>>{standard input}: Assembler messages:
>>{standard input}:1581: Error: symbol `use_acpi_pci' is already defined
>>make[1]: *** [pci-pc.o] Error 1
>>make[1]: Leaving directory `/usr/src/linux-2.4.23-rc2/arch/x86_64/kernel'
>>make: *** [_dir_arch/x86_64/kernel] Error 2A
> 
> 
> Samuel,
> 
> Len Brown just sent me a fix for this.
> 
> Can you please try again using the BK tree?

   I don't have a BK setup will patch-2.4.22-bk57.bz2 work?

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

