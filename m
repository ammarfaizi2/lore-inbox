Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264796AbUEYIA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264796AbUEYIA6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 04:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264799AbUEYIA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 04:00:58 -0400
Received: from mail.kroah.org ([65.200.24.183]:19101 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264796AbUEYIAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 04:00:55 -0400
Date: Tue, 25 May 2004 01:00:06 -0700
From: Greg KH <greg@kroah.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [BK PATCH] PCI Express patches for 2.4.27-pre3
Message-ID: <20040525080006.GA1047@kroah.com>
References: <20040524210146.GA5532@kroah.com> <1085468008.2783.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085468008.2783.1.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 08:53:28AM +0200, Arjan van de Ven wrote:
> On Mon, 2004-05-24 at 23:01, Greg KH wrote:
> > Hi,
> > 
> > Now that the ACPI portion of PCI Express support is in the 2.4 kernel
> > tree, I can send you the remaining portion to actually enable this
> > feature to work properly.  Here is the PCI Express support for i386 and
> > x86_64 platforms backported from 2.6 to the 2.4 kernel.
> 
> 
> how does this mesh with the "2.4 is now feature frozen"?

As the major chunk of ACPI support just got added to the tree, and the
only reason that went in was for this patch, I assumed that it was
acceptable.  Marcelo, feel free to tell me otherwise if you do not want
this in the 2.4 tree.

> Especially since you don't NEED this patch to run on pci express
> hardware, it's just that you can use a few performance tweaks.

I agree.

thanks,

greg k-h
