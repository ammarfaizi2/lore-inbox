Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264733AbUEYMxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264733AbUEYMxd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 08:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264737AbUEYMxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 08:53:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21935 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264733AbUEYMx2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 08:53:28 -0400
Date: Tue, 25 May 2004 09:54:53 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Greg KH <greg@kroah.com>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [BK PATCH] PCI Express patches for 2.4.27-pre3
Message-ID: <20040525125452.GC3118@logos.cnet>
References: <20040524210146.GA5532@kroah.com> <1085468008.2783.1.camel@laptop.fenrus.com> <20040525080006.GA1047@kroah.com> <20040525113231.GB29154@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525113231.GB29154@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi kernel fellows,

On Tue, May 25, 2004 at 12:32:31PM +0100, Matthew Wilcox wrote:
> On Tue, May 25, 2004 at 01:00:06AM -0700, Greg KH wrote:
> > > how does this mesh with the "2.4 is now feature frozen"?
> > 
> > As the major chunk of ACPI support just got added to the tree, and the
> > only reason that went in was for this patch, I assumed that it was
> > acceptable.

major? the MMConfig support is minimal as I can see? 

> > Marcelo, feel free to tell me otherwise if you do not want
> > this in the 2.4 tree. 

Is this code necessary for PCI-Express devices/busses to work properly?

> I assume it was added because Len tries to keep ACPI in 2.4 and 2.6 as
> close to identical as possible.  It certainly doesn't hurt anyone to add
> the ACPI functionality without the MMConfig support.

I've humbly asked Len to stop doing big updates whenever possible on the 
v2.4 ACPI code, and do bugfixes only instead. Is that a pain in the ass for you, Len?    

I asked that because it is common to see new bugs introduced by an ACPI update, 
and you know that more than I do.

Thanks!

PS: Greg, about the PCI-Express hotplug drivers, I assume they are independant 
on any of this?
