Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292694AbSBZWQY>; Tue, 26 Feb 2002 17:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293609AbSBZWQF>; Tue, 26 Feb 2002 17:16:05 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:63754 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S292694AbSBZWQD>;
	Tue, 26 Feb 2002 17:16:03 -0500
Date: Tue, 26 Feb 2002 14:09:40 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PCI Hotplug driver updates for 2.4.19-pre1
Message-ID: <20020226220940.GG1665@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 29 Jan 2002 19:52:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just sent off a bunch of PCI Hotplug patches for 2.4.19-pre1 and
thought I would post a pointer to them here (the patches are too large
for this mailing list.)

 - Clean up the pcihpfs filesystem code and add support for updating the
   timestamp of the device attribute files when the information has
   changed.
	kernel.org/pub/linux/kernel/people/gregkh/hotplug/2.4/pci_hp-core-2.4.19-pre1.patch

 - Add the PCI Hotplug API to the kernel-api documentation build
	kernel.org/pub/linux/kernel/people/gregkh/hotplug/2.4/pci_hp-docs-2.4.19-pre1.patch

 - Some small Compaq PCI Hotplug driver fixes
	kernel.org/pub/linux/kernel/people/gregkh/hotplug/2.4/pci_hp-cpqphp-2.4.19-pre1.patch

 - Add support for an IBM PCI Hotplug driver.  This was written by Irene
   Zubarev, Tong Yu, Jyoti Shah, and Chuck Cole, with a bit of help from
   me.
	kernel.org/pub/linux/kernel/people/gregkh/hotplug/2.4/pci_hp-ibmphp-2.4.19-pre1.patch

 - Add support for an ACPI PCI hotplug driver.  This was written by
   Hiroshi Aono and Takayoshi Kochi, with a bit of help from me.
	kernel.org/pub/linux/kernel/people/gregkh/hotplug/2.4/pci_hp-acpi-2.4.19-pre1.patch

 - Add the ACPI and IBM PCI Hotplug drivers to the build
	kernel.org/pub/linux/kernel/people/gregkh/hotplug/2.4/pci_hp-build-2.4.19-pre1.patch


thanks,

greg k-h
