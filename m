Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272691AbTHRTYt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 15:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272278AbTHRTYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 15:24:48 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:58534 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S272691AbTHRTXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 15:23:15 -0400
Subject: RE: 2.6.0-test3 latest bk hangs when enabling IO-APIC
From: Stian Jordet <liste@jordet.nu>
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FC6D@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE009FC6D@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Message-Id: <1061234596.594.3.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 18 Aug 2003 21:23:16 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man, 18.08.2003 kl. 19.53 skrev Brown, Len: 
> Try booting with pci=noacpi, and if that doesn't work acpi=off
> If either of those work, then file in bugzilla with component=ACPI and
> assign it to len.brown@intel.com

It works when booting with noapic, but not with acpi=off nor pci=noapic.
Does that mean I can't blame you for it?

Best regards,
Stian

> > --Original Message--
> > From: Stian Jordet [mailto:liste@jordet.nu] 
> > Sent: Monday, August 18, 2003 9:10 AM
> > To: linux-kernel@vger.kernel.org
> > Subject: 2.6.0-test3 latest bk hangs when enabling IO-APIC
> > 
> > 
> > Hello,
> > 
> > latest bk of 2.6.0-test3 hangs with these three lines:
> > 
> > ENABLING IO-APIC IRQs
> > Setting 2 in the phys_id_present_map
> > ...changing IO-APIC physical APIC ID to 2 ... ok.
> > 
> > And there it stays forever. 2.6.0-test3 worked like a charm. This is a
> > Asus CUV265-DLS motherboard. Dual P3.
> > 
> > Should I file a bugreport at bugzilla?
> > 
> > Best regards,
> > Stian

