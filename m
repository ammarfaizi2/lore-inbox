Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292233AbSCDIV3>; Mon, 4 Mar 2002 03:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292237AbSCDIVV>; Mon, 4 Mar 2002 03:21:21 -0500
Received: from ccs.covici.com ([209.249.181.196]:4253 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S292233AbSCDIVM>;
	Mon, 4 Mar 2002 03:21:12 -0500
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch??: linux-2.5.6-pre1/drivers/scsi/advansys.c DMA-mapping
 fixes
In-Reply-To: <200202281528.HAA06493@baldur.yggdrasil.com>
From: John Covici <covici@ccs.covici.com>
Date: Mon, 04 Mar 2002 03:20:10 -0500
In-Reply-To: <200202281528.HAA06493@baldur.yggdrasil.com> ("Adam J.
 Richter"'s message of "Thu, 28 Feb 2002 07:28:47 -0800")
Message-ID: <m3vgcc3ft1.fsf@ccs.covici.com>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.1.90
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following error when trying to install the advansys scsi
driver as a module:


depmod:         virt_to_bus_not_defined_use_pci_map

Any assistance would be appreciated.

on Thu, 28 Feb 2002 07:28:47 -0800 "Adam J. Richter" <adam@yggdrasil.com> wrote:

> 	The following is my attempt to at porting
> linux-2.5.6-pre1/drivers/scsi/advansys.c to the new DMA mapping
> scheme described in linux-2.5.6-pre1/Documentation/DMA-mapping.txt.
>
> 	Since I do not have an advansys card and I'm a bit green
> at doing these conversions, I would appreciate it someone who knows
> the advansys driver could take a look at this stuff and either
> tell me if I have missed something or take it from here.
