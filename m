Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265175AbUBATyF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 14:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265291AbUBATyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 14:54:05 -0500
Received: from fmr03.intel.com ([143.183.121.5]:32490 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S265175AbUBATyA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 14:54:00 -0500
Subject: Re: ACPI -- Workaround for broken DSDT
From: Len Brown <len.brown@intel.com>
To: bluefoxicy@linux.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0020AEB5C@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0020AEB5C@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1075665236.2392.16.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Feb 2004 14:53:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is probably best addressed to acpi-devel@lists.sourceforge.net
where people over-ride their BIOS ACPI DSDT all the time.

However, there is a reason that it isn't push-button, and that is
because we don't want to encourage people to do it.  We'd rather fix
Linux where Linux is broken, or get the OEMs to fix their BIOS where the
BIOS is broken.

thanks,
-Len


On Sat, 2004-01-31 at 14:39, john moser wrote:
> Please CC me all replies.
> 
> 
> http://abaababa.ouvaton.org/presario/
> 
> Please note that a recompiled and fixed DSDT table exists for the
> Compaq Presario
> 2100 series.  I would like to be able to simply point my kernel at
> this file at
> compile time from a configuration menu, and compile it in to the
> kernel.  I can
> probably find the DSDT load code myself, but compiling external data
> into a
> program and accessing it is something foreign to me (IDE's like
> Borland C++ Builder
> did it for you and so I never was able to learn how with GCC).
> 
> This may be useful in the future for broken ACPI.  Could someone
> please make a
> quick patch to allow the path of a DSDT table to be defined so that it
> may be
> compiled into the kernel and override the ACPI DSDT table in the
> BIOS?  I'll
> peek around, but ACPI and this sort of programming isn't my strong
> point.
> 
> If anyone is familiar with this area and would be willing to write up
> a patch,
> please CC me so I don't spend days/weeks trying to figure out how the
> heck to
> do this ;)
> 
> 
> 
> _____________________________________________________________
> Linux.Net -->Open Source to everyone
> Powered by Linare Corporation
> http://www.linare.com/
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

