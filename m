Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbUJXQbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbUJXQbz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 12:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbUJXQaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 12:30:08 -0400
Received: from ipx20189.ipxserver.de ([80.190.249.56]:62598 "EHLO
	ipx20189.ipxserver.de") by vger.kernel.org with ESMTP
	id S261549AbUJXQ2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 12:28:33 -0400
Date: Sun, 24 Oct 2004 19:27:06 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-mm1: NForce3 problem (IRQ sharing issue?)
In-Reply-To: <200410231928.43049.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.61.0410241921461.2982@musoma.fsmlabs.com>
References: <200410222354.44563.rjw@sisk.pl> <20041022162656.2f9ca653.akpm@osdl.org>
 <Pine.LNX.4.61.0410231424330.3073@musoma.fsmlabs.com> <200410231928.43049.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004, Rafael J. Wysocki wrote:

> > Could we also get a dmesg and lspci? Boot with the 'debug' kernel 
> > parameter.
> 
> Attached, for both 2.6.9-mm1 and 2.6.10-rc1.

Could you boot 2.6.10-rc1 with the 'noapic' kernel parameter and you may 
as well remove that pci=routeirq parameter, then send dmesg. Something 
appears hosed with respect to IOAPIC setup and i think ACPI is having 
trouble doing the fallback to PIC mode.

Thanks,
	Zwane
