Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266070AbUBQGb6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 01:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266075AbUBQGb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 01:31:58 -0500
Received: from fmr04.intel.com ([143.183.121.6]:18052 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S266070AbUBQGb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 01:31:56 -0500
Subject: Re: Linux 2.6.3-rc4 (nforce2)
From: Len Brown <len.brown@intel.com>
To: Felix Seeger <felix.seeger@gmx.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F262D@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F262D@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1076999506.2510.36.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 Feb 2004 01:31:46 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Should NForce2 boards also work without patches and with acpi/apic ?
> I saw a change in rc3.

Some will, some will not.  Note that Maciej's patch didn't address the
nforce2 timer configuration issue, which I believe requires a
platform-specific nforce2 patch.

> It just hangs again, so I switched back to my patched kernel.
> But of course this could be another problem, kernel 2.6.2-rc1 is
> running very 
> stable here with the apictack-rd and the ioapic-rd patches.

Dunno what those are, but if you still require ACPI-related patches,
please let me know.

thanks,
-Len


