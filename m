Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbTIYNda (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 09:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbTIYNda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 09:33:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18626 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261205AbTIYNd3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 09:33:29 -0400
Date: Thu, 25 Sep 2003 14:33:27 +0100 (BST)
From: marcelo@parcelfarce.linux.theplanet.co.uk
To: "Brown, Len" <len.brown@intel.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: RE: HT not working by default since 2.4.22
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC8708@hdsmsx402.hd.intel.com>
Message-ID: <Pine.LNX.4.44.0309251426570.30864-100000@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Sep 2003, Brown, Len wrote:

> Okay, so what to do?
> 
> We could make 2.4.23 like 2.4.21 where ACPI code for HT is included in
> the kernel even when CONFIG_ACPI is not set.
> 
> Or we could leave 2.4.23 like 2.4.22 where disabling CONFIG_ACPI really
> does remove all ACPI code in the kernel; and when CONFIG_ACPI is set,
> CONFIG_ACPI_HT_ONLY is available to limit ACPI to just the tables part
> needed for HT.

CONFIG_ACPI_HT should be not dependant on CONFIG_ACPI. So

1) Please make it very clear on the configuration that for HT 
CONFIG_ACPI_HT_ONLY is needed
2) Move it outside CONFIG_ACPI. 

OK? 

Thank you.


