Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265434AbTGADvN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 23:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265460AbTGADvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 23:51:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1699 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265434AbTGADvL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 23:51:11 -0400
Date: Tue, 1 Jul 2003 05:05:31 +0100
From: Matthew Wilcox <willy@debian.org>
To: Greg KH <greg@kroah.com>
Cc: willy@debian.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, Patrick Mochel <mochel@osdl.org>
Subject: Re: PCI domain stuff
Message-ID: <20030701040531.GB23597@parcelfarce.linux.theplanet.co.uk>
References: <1057010214.1277.11.camel@albertc> <20030630220758.GA27368@kroah.com> <1057014182.4048.3887.camel@cube> <20030630231515.GA27813@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030630231515.GA27813@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 04:15:15PM -0700, Greg KH wrote:
> > AFAIK, sysfs won't support mmap.
> 
> What do you want to mmap?  The PCI config space?

We need to support mmaping device resources.  I think this actually
merits being a first class sysfs concept -- turn a struct resource into
an mmapable file.  The current fugly ioctl really has to go.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
