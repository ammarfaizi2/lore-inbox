Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbUCaFrs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 00:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbUCaFrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 00:47:48 -0500
Received: from fmr05.intel.com ([134.134.136.6]:3559 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S261748AbUCaFrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 00:47:41 -0500
Subject: Re: Linux 2.6.5-rc3 [ACPI error message]
From: Len Brown <len.brown@intel.com>
To: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F6D2C@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F6D2C@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1080712050.983.308.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 Mar 2004 00:47:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-30 at 01:50, Dumitru Ciobarcianu wrote:
> On Mon, 2004-03-29 at 21:35 -0800, Linus Torvalds wrote:
> > And agp, acpi, ISDN and watchdog.
> > 
> > Nothing earth-shattering, in other words.
> 
> 
> My laptop's acpi shaked a bit...
> 
> ACPI: Subsystem revision 20040326
> ACPI: IRQ9 SCI: Level Trigger.
>     ACPI-1133: *** Error: Method execution failed
> [\_SB_.PCI0.PCIB.MPC0._PRW] (Node c1521780), AE_NOT_EXIST
>     ACPI-0154: *** Error: Method execution failed
> [\_SB_.PCI0.PCIB.MPC0._PRW] (Node c1521780), AE_NOT_EXIST
> ACPI: Interpreter enabled

If you can send me the output from acpidmp, available in
/usr/sbin or in pmtools here
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

I can find out why you get these.

thanks,
-Len


