Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422970AbWBAWde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422970AbWBAWde (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 17:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422986AbWBAWdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 17:33:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17134 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422970AbWBAWdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 17:33:33 -0500
Date: Wed, 1 Feb 2006 17:33:08 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linda Xie <lxie@us.ibm.com>, John Rose <johnrose@austin.ibm.com>
Subject: missing symbols on ppc64 in -git5
Message-ID: <20060201223308.GA8588@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linda Xie <lxie@us.ibm.com>, John Rose <johnrose@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ppc64 builds got a bunch of new missing symbols..

drivers/pci/hotplug/rpaphp.ko needs unknown symbol pcibios_add_pci_devices
drivers/pci/hotplug/rpaphp.ko needs unknown symbol pcibios_find_pci_bus
drivers/pci/hotplug/rpadlpar_io.ko needs unknown symbol rpaphp_deregister_slot
drivers/pci/hotplug/rpadlpar_io.ko needs unknown symbol pcibios_find_pci_bus
drivers/pci/hotplug/rpadlpar_io.ko needs unknown symbol pcibios_fixup_new_pci_devices

		Dave

