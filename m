Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264884AbUFOIg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbUFOIg6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 04:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUFOIg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 04:36:57 -0400
Received: from docsis224-219.menta.net ([62.57.224.219]:5611 "EHLO
	pof.eslack.org.") by vger.kernel.org with ESMTP id S264884AbUFOIgz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 04:36:55 -0400
Subject: Re: pcibios_write_config_dword()?  porting drivers to 2.6
From: Esteve =?ISO-8859-1?Q?Espu=F1a?= Sargatal <esteve@eslack.org>
Reply-To: esteve@eslack.org
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040614215732.GA29550@havoc.gtf.org>
References: <20040614214554.GA25127@havoc.gtf.org>
	 <20040614215732.GA29550@havoc.gtf.org>
Content-Type: text/plain
Message-Id: <1087288594.7302.2.camel@esteve.pofhq.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 15 Jun 2004 10:36:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-14 at 23:57, Jeff Garzik wrote:
> On Mon, Jun 14, 2004 at 05:45:54PM -0400, David Eger wrote:
> > I've been working on a port of the Cirrus Logic framebuffer driver to
> > Linux 2.6, and stumbled upon the line:
> > 
> >       pcibios_write_config_dword (0, pdev->devfn, PCI_BASE_ADDRESS_0,
> >          0x00000000);
> > 
> > What did this used to mean?  It's been deleted as old cruft in 2.6...
> 
> pci_write_config_dword
> 

But done through the bios routine.

> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

