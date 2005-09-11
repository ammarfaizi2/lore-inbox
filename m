Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVIJXlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVIJXlY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 19:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVIJXlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 19:41:24 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:22448 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932383AbVIJXlW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 19:41:22 -0400
Subject: Re: [PATCH] include: pci_find_device remove
	(include/asm-i386/ide.h)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jiri Slaby <jirislaby@gmail.com>,
       Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
In-Reply-To: <20050910211932.GA13679@kroah.com>
References: <200509102032.j8AKWxMC006246@localhost.localdomain>
	 <4323482E.2090409@pobox.com>  <20050910211932.GA13679@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 11 Sep 2005 01:06:20 +0100
Message-Id: <1126397180.30449.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-09-10 at 14:19 -0700, Greg KH wrote:
> > Looks like we need to resurrect pci_present() from the ancient past.
> 
> Heh, ick, no :)
> 
> Jiri, any other way to do this instead?

IDE really does want to know if you have a PCI bus of any kind attached.
Perhaps pci_present should really come back - its better than hiding the
gory details in drivers

