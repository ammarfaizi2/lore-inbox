Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbUDVDMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUDVDMc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 23:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbUDVDMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 23:12:32 -0400
Received: from fmr01.intel.com ([192.55.52.18]:51926 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S261791AbUDVDMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 23:12:30 -0400
Subject: Re: wrong irq rouing on centrino laptop
From: Len Brown <len.brown@intel.com>
To: Andrey Ulanov <drey@acronis.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F938A@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F938A@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1082603536.16334.156.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 21 Apr 2004 23:12:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-20 at 09:28, Andrey Ulanov wrote:
> Hi!
> 
> I'm trying to use Intel Wireless 2100 adapter on my centrino based
> notebook. I use ipw2100 drivers from ipw2100.sf.net. The thing is that
> hardware says that the device should generate irq11, but it really
> generates irq5. I tryed both 2.4.26 and 2.6.5. I also tryed to compile
> kernel with and without ACPI. I tryed to compile kernel with and
> without APIC support. I also tryed to pass some parameters to kernel
> (acpi=off, acpi=force, pci=biosirq). But anyway kernel says irq 11 and
> device generates irq5. Of course it is possible to be hardware
> problem, but it works under windows.
> 
> Any suggestions?

> Linux version 2.4.22-1.2174.nptl.asp (root@dhcp6-121.acronis.ru) (gcc
> version 3.3.2 20031022 (ASPLinux 3.3.2-1)) #20 Tue Apr 20 07:00:48 MSD
> 2004

> ACPI: Subsystem revision 20031002

Please try a newer kernel, such as 2.4.26, or 2.6.5
and let me know if you still have a problem there.

thanks,
-Len


