Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751647AbWJMM3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbWJMM3O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 08:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbWJMM3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 08:29:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:37291 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751647AbWJMM3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 08:29:13 -0400
Subject: Re: [linux-pm] Bug in PCI core
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Martin Mares <mj@ucw.cz>
Cc: Adam Belay <abelay@MIT.EDU>, Alan Stern <stern@rowland.harvard.edu>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <mj+md-20061013.093014.26714.atrey@ucw.cz>
References: <Pine.LNX.4.44L0.0610111632240.6353-100000@iolanthe.rowland.org>
	 <1160701263.4792.179.camel@localhost.localdomain>
	 <1160729427.26091.98.camel@localhost.localdomain>
	 <1160731004.4792.245.camel@localhost.localdomain>
	 <mj+md-20061013.093014.26714.atrey@ucw.cz>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 22:25:50 +1000
Message-Id: <1160742350.4792.257.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-13 at 11:31 +0200, Martin Mares wrote:
> Hi!
> 
> > For example, currently, if I power off the ethernet of my mac, or the
> > firewire chip (which are powered off if the module isn't loaded), lspci
> > will get the device id and vendor id right ... but won't get the class
> > code.
> 
> Ehm, you aren't using any recent pciutils, are you? ;-)

Whatever came with the distro that complained about the problem back
then :) I agree that the problem is fixed on the kernel level (sysfs)
and I'm happy to hear that pciutils is fixed too :) So we can probably
do what Adam suggest and just return errors or ff's

Ben.


