Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTFXSER (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 14:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbTFXSER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 14:04:17 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:62176 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262568AbTFXSEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 14:04:10 -0400
Date: Tue, 24 Jun 2003 11:18:13 -0700
From: Greg KH <greg@kroah.com>
To: James Haydon <enochlnx@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.5.73
Message-ID: <20030624181813.GA1328@kroah.com>
References: <1056477054.21052.5.camel@daedalus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056477054.21052.5.camel@daedalus>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 01:50:54PM -0400, James Haydon wrote:
> 1. It does not link.
> 2. No reason to have hot pci plugins.
> drivers/pci/hotplug.c: In function `pci_remove_bus_device':
> drivers/pci/hotplug.c:262: warning: implicit declaration of function
> `pci_destroy_dev'
> include/linux/module.h: At top level:
> drivers/pci/hotplug.c:224: warning: `pci_free_resources' defined but not
> used
> 3. Error linking driver/built-in.o
> drivers/built-in.o(.text+0x31b6): In function `pci_remove_bus_device':
> : undefined reference to `pci_destroy_dev'
> make: *** [.tmp_vmlinux1] Error 1
> 4. Attached .config file
> 5. OS Redhat 9

6. Patch and workaround posted to lkml _many_ times in the past few
days.  Please search the archives before posting.

thanks,

greg k-h
