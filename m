Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267578AbUHJSVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267578AbUHJSVT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267631AbUHJSRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:17:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:3041 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267652AbUHJSQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:16:07 -0400
Date: Tue, 10 Aug 2004 09:40:31 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dsaxena@plexity.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Remove spaces from PCI IDE pci_driver.name field
Message-ID: <20040810164031.GB31655@kroah.com>
References: <20040810001316.GA7292@plexity.net> <1092096699.14934.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092096699.14934.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 01:11:42AM +0100, Alan Cox wrote:
> On Maw, 2004-08-10 at 01:13, Deepak Saxena wrote:
> > Spaces in driver names show up as spaces in sysfs. Annoying.  
> > I went ahead and changed ones that don't have spaces to use
> > ${NAME}_IDE so they are all consistent.
> 
> I don't see the problem with spaces in the filenames. I do see the 
> problem in changing stuff under people for now reason other than
> "I don't like it".

We tried to keep spaces out of device and driver names from the very
beginning, in 2.5 during the conversion to the driver model, due to the
confusion it caused people.  It seems that a few have snuck back in.
I'm all for consistancy, so I'll apply these patches.

thanks,

greg k-h
