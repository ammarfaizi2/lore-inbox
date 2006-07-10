Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161293AbWGJBta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161293AbWGJBta (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 21:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161292AbWGJBta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 21:49:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54738 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964976AbWGJBt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 21:49:29 -0400
Date: Sun, 9 Jul 2006 18:46:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: "Brown, Len" <len.brown@intel.com>, Miles Lane <miles.lane@gmail.com>,
       "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, gregkh@suse.de,
       linux-acpi@vger.kernel.org
Subject: Re: 2.6.17-mm2 -- drivers/built-in.o: In function
 `is_pci_dock_device':acpiphp_glue.c:(.text+0x12364): undefined reference to
 `is_dock_device'
In-Reply-To: <20060709231218.GU13938@stusta.de>
Message-ID: <Pine.LNX.4.64.0607091845360.5623@g5.osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB6ECF9E7@hdsmsx411.amr.corp.intel.com>
 <20060709231218.GU13938@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Jul 2006, Adrian Bunk wrote:
> 
> This patch looks wrong since it allows the illegal configuration
> ACPI_IBM_DOCK=y, HOTPLUG_PCI_ACPI=y/m, ACPI_DOCK=y/m.

Len?

		Linus
