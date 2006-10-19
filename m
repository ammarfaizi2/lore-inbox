Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161028AbWJSJXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbWJSJXK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 05:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbWJSJXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 05:23:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13713 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030363AbWJSJXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 05:23:08 -0400
Date: Thu, 19 Oct 2006 05:22:56 -0400
From: Alan Cox <alan@redhat.com>
To: David Miller <davem@davemloft.net>
Cc: eiichiro.oiwa.nm@hitachi.com, alan@redhat.com, jesse.barnes@intel.com,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: pci_fixup_video change blows up on sparc64
Message-ID: <20061019092256.GC5980@devserv.devel.redhat.com>
References: <20061018.233102.74754142.davem@davemloft.net> <XNM1$9$0$4$$3$3$7$A$9002705U45372f1d@hitachi.com> <20061019.013732.30184567.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061019.013732.30184567.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 01:37:32AM -0700, David Miller wrote:
> defined to do this kind of thing, for example with the
> pcibios_bus_to_resource() interface, used by routines such as
> drivers/pci/quirks.c:quirk_io_region().

pci_iomap() ?

Alan

