Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264891AbUEYOnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264891AbUEYOnH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 10:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264895AbUEYOnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 10:43:07 -0400
Received: from mail.kroah.org ([65.200.24.183]:25299 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264891AbUEYOml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 10:42:41 -0400
Date: Tue, 25 May 2004 07:41:49 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [BK PATCH] PCI Express patches for 2.4.27-pre3
Message-ID: <20040525144149.GB7252@kroah.com>
References: <20040524210146.GA5532@kroah.com> <1085468008.2783.1.camel@laptop.fenrus.com> <20040525080006.GA1047@kroah.com> <20040525113231.GB29154@parcelfarce.linux.theplanet.co.uk> <20040525125452.GC3118@logos.cnet> <20040525130116.GA16852@devserv.devel.redhat.com> <20040525132413.GD29154@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525132413.GD29154@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 02:24:13PM +0100, Matthew Wilcox wrote:
> On Tue, May 25, 2004 at 03:01:16PM +0200, Arjan van de Ven wrote:
> > 
> > On Tue, May 25, 2004 at 09:54:53AM -0300, Marcelo Tosatti wrote:
> > > > > Marcelo, feel free to tell me otherwise if you do not want
> > > > > this in the 2.4 tree. 
> > > 
> > > Is this code necessary for PCI-Express devices/busses to work properly?
> > 
> > afaik not. It's an enhancement to make config space access to them somewhat
> > faster, but they just work using the existing method.
> 
> It also allows access to the top 3840 bytes of config space.  The *spec*
> says you can't require access to that area for correct functioning of
> the device, but we all know how much people love to follow specs.

As no one really has PCI Express devices at this time, who knows how
badly the vendors will mess them up :)

thanks,

greg k-h
