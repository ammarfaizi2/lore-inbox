Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbUJaFIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbUJaFIh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 01:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbUJaFIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 01:08:37 -0400
Received: from fmr12.intel.com ([134.134.136.15]:17066 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S261503AbUJaFIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 01:08:36 -0400
Subject: Re: PCI->APIC IRQ transform -> 267 ?
From: Len Brown <len.brown@intel.com>
To: Robert Clark <lkml@ratty.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1098958286.6342.63.camel@localhost>
References: <1098958286.6342.63.camel@localhost>
Content-Type: text/plain
Organization: 
Message-Id: <1099199311.18178.4.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 Oct 2004 01:08:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-28 at 06:11, Robert Clark wrote:
> I'm getting this with 2.4.27 (SMP):
> 
> PCI: Using IRQ router PIIX [8086/25a1] at 00:1f.0
...
> PCI->APIC IRQ transform: (B3,I4,P0) -> 267

this is from pcibios_fixup_irqs() which is called only when ACPI is
disabled.  Let me know if you still have trouble with a kernel built
with CONFIG_ACPI=y.  Also, it would be good to know if other versions of
the kernel are known to work, or if they all fail on this box.

thanks,
-Len


