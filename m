Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271082AbTHGXDo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 19:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271089AbTHGXDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 19:03:44 -0400
Received: from fed1mtao05.cox.net ([68.6.19.126]:5278 "EHLO fed1mtao05.cox.net")
	by vger.kernel.org with ESMTP id S271082AbTHGXDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 19:03:40 -0400
Date: Thu, 7 Aug 2003 16:03:39 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: long <tlnguyen@snoqualmie.dp.intel.com>, linux-kernel@vger.kernel.org,
       jun.nakajima@intel.com, tom.l.nguyen@intel.com, greg@kroah.com
Subject: Re: Updated MSI Patches
Message-ID: <20030807160339.A23240@home.com>
References: <200308072125.h77LPKUN024461@snoqualmie.dp.intel.com> <3F32D65E.4040605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3F32D65E.4040605@pobox.com>; from jgarzik@pobox.com on Thu, Aug 07, 2003 at 06:44:46PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 06:44:46PM -0400, Jeff Garzik wrote:
> long wrote:
> 
> 
> > diff -X excludes -urN linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/pci_msi.c linux-2.6.0-test2-create-msi/arch/i386/kernel/pci_msi.c
> > --- linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/pci_msi.c	1969-12-31 19:00:00.000000000 -0500
> > +++ linux-2.6.0-test2-create-msi/arch/i386/kernel/pci_msi.c	2003-08-06 09:47:02.000000000 -0400
> 
> Seems like a lot of this file could go into a new file, 
> drivers/pci/msi.c.  We'll want to share as much code as possible across 
> all Linux architectures.

Yes.  The on-chip PCI-X host bridge on PPC44x parts has MSI support, so
I can make use of this if it goes in the right place.
 
--
Matt Porter
mporter@kernel.crashing.org
