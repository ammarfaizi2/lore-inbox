Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTJYVGj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 17:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263004AbTJYVGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 17:06:38 -0400
Received: from storm.he.net ([64.71.150.66]:33261 "HELO storm.he.net")
	by vger.kernel.org with SMTP id S262960AbTJYVGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 17:06:34 -0400
Date: Sat, 25 Oct 2003 14:05:50 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <willy@debian.org>
Cc: "Moore, Eric Dean" <emoore@lsil.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  2.4.23-pre8 driver udpate for MPT Fusion (2.05.10)
Message-ID: <20031025210550.GB23437@kroah.com>
References: <0E3FA95632D6D047BA649F95DAB60E57035A9458@exa-atlanta.se.lsil.com> <20031025191828.GA17144@kroah.com> <20031025204405.GB5172@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031025204405.GB5172@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 25, 2003 at 09:44:05PM +0100, Matthew Wilcox wrote:
> On Sat, Oct 25, 2003 at 12:18:28PM -0700, Greg KH wrote:
> > On Fri, Oct 24, 2003 at 11:12:25AM -0400, Moore, Eric Dean wrote:
> > > I'm going to be working on that.
> > > Can't say when its going to be ready.
> > 
> > How about support for all of the pci hotplug systems on 2.4 that are
> > shipping today? 
> 
> The SCSI system isn't really capable of supporting hotplug PCI in 2.4.

Yeah, but some drivers almost do (Adaptec comes to mind.)  It will work
in a pci hotplug system, while other scsi drivers will not work at all.

thanks,

greg k-h
