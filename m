Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268760AbUHaSxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268760AbUHaSxX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 14:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268776AbUHaSxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 14:53:23 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:4562 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268760AbUHaSxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 14:53:19 -0400
Date: Tue, 31 Aug 2004 11:53:06 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm2
Message-ID: <230680000.1093978386@flay>
In-Reply-To: <20040830235426.441f5b51.akpm@osdl.org>
References: <20040830235426.441f5b51.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm2/
> 
> Nothing particularly noteworthy here.  Some seriously bad scheduler
> performance with SMT and HT was fixed up, as was the
> fails-to-read-the-last-4k-of-a-file brown bag.

Something is borked in ACPI:

drivers/built-in.o(.text+0x1cf2c): In function `acpi_pci_root_add':
/root/linux/2.6.9-rc1-mm2/drivers/acpi/pci_root.c:270: undefined reference to `pci_acpi_scan_root'

Didn't actually realise I had ACPI config'ed in, so will just get rid of
it, but though you might want to know.

M.

