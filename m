Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265830AbTGAETt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 00:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265856AbTGAETt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 00:19:49 -0400
Received: from rth.ninka.net ([216.101.162.244]:30338 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S265830AbTGAETs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 00:19:48 -0400
Subject: Re: PCI domain stuff
From: "David S. Miller" <davem@redhat.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, Patrick Mochel <mochel@osdl.org>
In-Reply-To: <20030701040531.GB23597@parcelfarce.linux.theplanet.co.uk>
References: <1057010214.1277.11.camel@albertc>
	 <20030630220758.GA27368@kroah.com> <1057014182.4048.3887.camel@cube>
	 <20030630231515.GA27813@kroah.com>
	 <20030701040531.GB23597@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1057034041.31826.1.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 30 Jun 2003 21:34:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-30 at 21:05, Matthew Wilcox wrote:
> We need to support mmaping device resources.  I think this actually
> merits being a first class sysfs concept -- turn a struct resource into
> an mmapable file.  The current fugly ioctl really has to go.

What's so wrong with the "fugly ioctl"?

What can't you do with it?

You can even mmap the complete I/O space of a PCI bus (in order to poke
around in implicit I/O resources like the VGA registers that a PCI card
might respond to).

