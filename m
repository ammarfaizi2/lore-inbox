Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270438AbTHSMyy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 08:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270447AbTHSMyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 08:54:54 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:33719 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S270438AbTHSMyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 08:54:53 -0400
Subject: RE: [SOLVED] RE: 2.6.0-test3 latest bk hangs when enabling IO-APIC
From: Stian Jordet <liste@jordet.nu>
To: "Brown, Len" <len.brown@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FC7B@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE009FC7B@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Message-Id: <1061297641.649.4.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 14:54:01 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 19.08.2003 kl. 05.17 skrev Brown, Len:
> > So... concrete suggestions?  Overall, IMO, move everything under 
> > CONFIG_ACPI, or, make CONFIG_ACPI_BOOT a _peer_ option, whose 
> > selection 
> > or lackthereof doesn't affect CONFIG_ACPI visibility at all.
> 
> Simply re-naming CONFIG_ACPI_HT to be CONFIG_ACPI_BOOT might help, as it
> would be more clear that it is necessary for the rest of ACPI.  However,
> it may not be obvious that it provides the minimal config to enable HT.
> 
> Re: peers
> Unfortunately ACPI doesn't work so well if CONFIG_ACPI_BOOT is left out.
> Yes, it's conceivable, but I spent several hours tinkering with it in
> search of a "noht" build option, but ditched it b/c it seemed like a
> build option very few would use.
> 
> Re: CONFIG_ACPI is the the master switch, and all other ACPI options
> subservient...
> If implemented literally, this is sort of a pain, as CONFIG_ACPI appears
> all over the code.  However, a dummy config master ACPI config option
> could be used to enable the menu that contains all the rest of ACPI...

Btw, (a little off-topic) should I file a bug-report that my motherboard
doesn't boot without acpi (never has, not even with 2.4), or should I
just smile and be happy because acpi works like a charm? (I already do
that :)

Thanks.

Regards,
Stian

