Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbUDWVDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUDWVDL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 17:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUDWVDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 17:03:11 -0400
Received: from linux-bt.org ([217.160.111.169]:36996 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S261421AbUDWVDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 17:03:08 -0400
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>
In-Reply-To: <20040423213546.C2896@flint.arm.linux.org.uk>
References: <200404230142.46792.dtor_core@ameritech.net>
	 <200404230802.42293.dtor_core@ameritech.net>
	 <1082730412.23959.118.camel@pegasus>
	 <200404231156.03106.dtor_core@ameritech.net>
	 <20040423171614.GA13835@kroah.com>
	 <20040423213546.C2896@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1082754162.4294.10.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 23 Apr 2004 23:02:42 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

> > Much nicer (well, in a wierd way at least.)  It seems that the pcmcia
> > system is intregrated into the driver model.  Why not push it down into
> > the individual pcmcia drivers so you don't have to do this GetSysDevice
> > kind of hack still?
> 
> They're actually getting at is the PCI device, or statically allocated
> platform device, rather than anything specific to the card.
> 
> Obviously this is going to create the silly scenario where people
> can attach PCMCIA device attributes to the bridge device, which
> provides the wrong API to userspace.

do you have any proposals how to fix this now? We only need the device
for loading the firmware.

Regards

Marcel


