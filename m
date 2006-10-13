Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWJMPkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWJMPkK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 11:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWJMPkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 11:40:10 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37552 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751228AbWJMPkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 11:40:08 -0400
Subject: Re: [linux-pm] Bug in PCI core
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Adam Belay <abelay@MIT.EDU>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <1160753390.3000.494.camel@laptopd505.fenrus.org>
References: <Pine.LNX.4.44L0.0610131024340.6460-100000@iolanthe.rowland.org>
	 <1160753187.25218.52.camel@localhost.localdomain>
	 <1160753390.3000.494.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Oct 2006 17:06:02 +0100
Message-Id: <1160755562.25218.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-13 am 17:29 +0200, ysgrifennodd Arjan van de Ven:
> > And then you can fix the applications it breaks, like the X server which
> > does actually want to know where all the devices are located in PCI
> > space.
> > 
> 
> .. but which could equally well mmap the resource from sysfs ;)

That doesn't help deal with the location and PCI control side of things
X has to perform and deal with. You also forgot to attach the tested
patch set for the X server and other affected apps.

The cached stuff was put in place precisely because stuff broke

