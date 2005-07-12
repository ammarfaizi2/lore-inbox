Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbVGLW4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVGLW4z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbVGLWyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:54:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:53978 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262465AbVGLWwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:52:36 -0400
Date: Tue, 12 Jul 2005 15:52:25 -0700
From: Greg KH <greg@kroah.com>
To: rajatj@noida.hcltech.com
Cc: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org,
       rajatxjain@yahoo.com
Subject: Re: Problem while inserting pciehp (PCI Express Hot-plug) driver
Message-ID: <20050712225225.GA29690@kroah.com>
References: <1e2adab705071202015fb9aa50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e2adab705071202015fb9aa50@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 06:01:22PM +0900, Rajat Jain wrote:
> Hi,
> 
> I'm trying to use the PCI Express Hot-Plug Controller driver
> (pciehp.ko) with Kernel 2.6 so that I can get hot-plug events whenever
> I add a card to my PCI Express slot.
> 
> I built the driver as a module, and am trying to load it manually
> using modprobe. However, when trying to insert, I'm getting the
> following error:
> 
> pciehp: acpi_pciehprm:\_SB.PCI0 _OSC fails=0x5
> pciehp: Both _OSC and OSHP methods do not exist
> FATAL: Error inserting pciehp
> (/lib/modules/2.6.9-5.18AXcustom-hotplug/kernel/drivers/pci/hotplug/pciehp.ko):
> No such device

Your bios does not support pci express hotplug.  Are you sure you have
pci express hotplug hardware in your system?  If so, contact your bios
vendor to get an updated version.

Good luck,

greg k-h
