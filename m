Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbTI3FSQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 01:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263127AbTI3FSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 01:18:16 -0400
Received: from fmr04.intel.com ([143.183.121.6]:19360 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263126AbTI3FSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 01:18:12 -0400
Subject: Re: [PATCH] ACPI pci irq routing fix
From: Len Brown <len.brown@intel.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Chris Wright <chrisw@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net,
       Andrew de Quincey <adq_dvb@lidskialf.net>
In-Reply-To: <3F752619.5000406@cyberone.com.au>
References: <20030926182128.C24360@osdlab.pdx.osdl.net>
	 <3F752619.5000406@cyberone.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1064899042.2532.101.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 30 Sep 2003 01:17:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-09-27 at 01:54, Nick Piggin wrote:
> Chris Wright wrote:
> 
> >If irq.active is set from _CRS, make sure to use it
...
> and fixes bug #1186.
> >
> >Patch originally from Andrew de Quincey.
> >
> 
> This fixes my bug #1257.
> 

This fix has been integrated with others in the ACPI patch,
and is available now in these bitkeeper trees:

http://linux-acpi.bkbits.net/linux-acpi-test-2.4.22
http://linux-acpi.bkbits.net/linux-acpi-test-2.4.23
http://linux-acpi.bkbits.net/linux-acpi-test-2.6.0

It is also available as a plain patch "acpi_pci_link_allocate" here:

ftp.kernel.org:/pub/linux/kernel/people/lenb/acpi/patches/test/*

thanks,
-Len


