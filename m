Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbUDMShz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 14:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263671AbUDMShz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 14:37:55 -0400
Received: from ns.suse.de ([195.135.220.2]:52445 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263662AbUDMShw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 14:37:52 -0400
Date: Tue, 13 Apr 2004 20:37:50 +0200
From: Andi Kleen <ak@suse.de>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       tom.l.nguyen@intel.com
Subject: Re: [PATCH] PCI MSI Kconfig consolidation
Message-Id: <20040413203750.01fac421.ak@suse.de>
In-Reply-To: <200404131041.06275.bjorn.helgaas@hp.com>
References: <200404131041.06275.bjorn.helgaas@hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2004 10:41:06 -0600
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> This consolidates the PCI MSI configuration into drivers/pci/Kconfig,
> removing it from the i386, x86_64, and ia64 Kconfig.
> 
> It also changes the default for ia64 from "y" to "n".  The default on
> i386 is "n" already, and I'm not sure why ia64 should be different.

Looks good to me. Hopefully the indexed support on x86-64 can be fixed
soon, then even the !X86_64 will be unnecessary.

-Andi
