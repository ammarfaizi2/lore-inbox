Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTJANbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 09:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbTJANbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 09:31:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59360 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262116AbTJANbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 09:31:05 -0400
Date: Wed, 1 Oct 2003 15:31:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Wilcox <willy@debian.org>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com
Subject: Re: [ACPI] ACPI blacklisting: move year blacklist into acpi/blacklist.c
Message-ID: <20031001133104.GA21626@atrey.karlin.mff.cuni.cz>
References: <20031001101826.GA3503@elf.ucw.cz> <20031001122412.GJ24824@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001122412.GJ24824@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > AFAICS. It also adds some externs to include/linux/acpi.h, but I
> > believe *way* more externs are needed. Please apply,
> 
> > --- /usr/src/tmp/linux/include/linux/acpi.h	2003-08-27 12:00:48.000000000 +0200
> > +++ /usr/src/linux/include/linux/acpi.h	2003-10-01 11:53:51.000000000 +0200
> > @@ -403,8 +403,8 @@
> >  
> >  struct pci_dev;
> >  
> > -int acpi_pci_irq_enable (struct pci_dev *dev);
> > -int acpi_pci_irq_init (void);
> > +extern int acpi_pci_irq_enable (struct pci_dev *dev);
> > +extern int acpi_pci_irq_init (void);
> 
> Why do they need to be externs?  The comp.lang.c FAQ suggests they don't
> have to be.
> 
> http://www.eskimo.com/~scs/C-faq/q1.11.html

Well, they don't *have* to be there, but as FAQ says, it is stylistics
hint.


									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
