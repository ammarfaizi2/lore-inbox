Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266485AbUGKChD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUGKChD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 22:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUGKChD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 22:37:03 -0400
Received: from fmr01.intel.com ([192.55.52.18]:33746 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S266485AbUGKCg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 22:36:59 -0400
Subject: Re: 2.6.7-mm7
From: Len Brown <len.brown@intel.com>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FFA8A@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FFA8A@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1089513407.32034.51.camel@dhcppc2>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 10 Jul 2004 22:36:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-09 at 04:15, Stefano Rivoir wrote:
> Andrew Morton wrote:
> 
> >
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/
> 
> Still hangs on boot, like -mm5 did,
> 
>    1. just after the ide0 recognition, last lines are:
> 
> hda: QSI CD-RW/DVD-ROM SBW-242, ATAPI CD/DVD-ROM drive
> Using anticipatory io scheduler
> ide0 at 0x1f0-0x1f7, 0x3f6 on irq14
> 
>    2. just after the ACPI processor module insert, last line is
> 
> ACPI: Processor [CPU0] (supports C1, C2, C3, 8 throttling states)
> 
> 2.6.7-bk20 runs fine instead.

The dmesg you attached was for -mm4
I didn't see anything wrong with it.
Is it an example of a successful, or a hung boot?

I don't understand the description above -- are you saying that
boot hangs at boot in one of two places?  Any difference if
you remove the processor module, or build w/o CONFIG_ACPI_PROCESSOR?

Do other versions before -mm5 work okay?

thanks,
-Len



