Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbTFXUbq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 16:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTFXUbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 16:31:46 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:32175 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262636AbTFXUbp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 16:31:45 -0400
Date: Tue, 24 Jun 2003 13:45:35 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [PATCH] AMD PCI Hotplug driver for 2.4 and 2.5
Message-ID: <20030624204535.GA2132@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As a number of people are starting to ask about this, I've released both
a 2.4.21 and 2.5.73 version of the AMD SHPC PCI Hotplug driver.  The
patches are at:
  kernel.org/pub/linux/kernel/people/gregkh/pci-hotplug/2.4/pci_hp-amdshpc-2.4.21.patch
and
  kernel.org/pub/linux/kernel/people/gregkh/pci-hotplug/2.5/pci_hp-amdshpc-2.5.73.patch

This work was almost entirely done by David Keck, with the 2.5 port done
by me.  Any bugs present are my fault because of the porting.  Thanks go
out to AMD for doing this development and releasing the code.

The driver isn't ready to be added to the kernel yet, this is just a
heads up for those people out there wanting to see a SHPC[1] driver, or who
have access to amd64 hardware with this chip in it.

thanks,

greg k-h

[1] SHPC = Standard Hotplug Pci Controller, the "finalized" spec by the
    PCI specification committee.
