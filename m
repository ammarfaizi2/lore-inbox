Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbVJLOeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbVJLOeg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 10:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVJLOeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 10:34:36 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:18149 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964794AbVJLOef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 10:34:35 -0400
Subject: Re: [ACPI] 2.6.14-rc4 ACPI/PCI compile problem
From: Adam Litke <agl@us.ibm.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200510111717.01887.bjorn.helgaas@hp.com>
References: <1129069727.27663.8.camel@localhost.localdomain>
	 <200510111717.01887.bjorn.helgaas@hp.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 12 Oct 2005 09:34:28 -0500
Message-Id: <1129127668.14471.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-11 at 17:17 -0600, Bjorn Helgaas wrote:
> On Tuesday 11 October 2005 4:28 pm, Adam Litke wrote:
> > Ok I'll admit I've known about this since at least 2.6.14-rc2-git5 but
> > it may have been around longer.  Long enough for me to speak up.
> > 
> > I am getting the following compile errors when building 2.6.14-rc4 for
> > i386:
> > 
> > >   LD      .tmp_vmlinux1
> > > drivers/built-in.o(.text+0x235f9): In function `acpi_pci_root_add':
> > > /home/aglitke/views/acpi-compile-fix-2.6.14-rc4/current/drivers/acpi/pci_root.c:274: undefined reference to `pci_acpi_scan_root'
> > > make[1]: *** [.tmp_vmlinux1] Error 1
> > > make: *** [_all] Error 2
> 
> Please try the following patch and confirm whether it works.

Yep, that fixes it, thanks.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

