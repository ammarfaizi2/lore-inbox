Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268088AbUBRVBo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 16:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268082AbUBRVA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 16:00:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:14296 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268087AbUBRVAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 16:00:51 -0500
Date: Wed, 18 Feb 2004 12:57:41 -0800
From: Greg KH <greg@kroah.com>
To: johnrose@austin.ibm.com
Cc: linux-kernel@vger.kernel.org, gregkh@us.ibm.com, lxie@us.ibm.com,
       wortman@us.ibm.com, scheel@us.ibm.com,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PPC64 PCI Hotplug Driver for RPA
Message-ID: <20040218205741.GB5175@kroah.com>
References: <200402110112.i1B1CToT022755@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402110112.i1B1CToT022755@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 07:12:29PM -0600, johnrose@austin.ibm.com wrote:
> Please consider the following patch for submission.  This patch contains the
> implementation of the I/O Slot DLPAR Drivers for PPC64 RISC Platform
> Architecture.  This module depends on the RPA PCI Hotplug Module in the
> previous post.  The patch is made against kernel version 2.6.3-rc2.  
> 
> The Dynamic Logical Partitioning Module allows the runtime movement of I/O
> Slots between logical partitions.  An administrator can logically add/remove
> PCI Buses to/from a PPC64 partition at runtime.  These operations are initiated
> using interface files located at:
> /sys/bus/pci/pci_hotplug_slots/control/
> Development contact for this module is John Rose (johnrose@austin.ibm.com).

Applied, thanks.

greg k-h
