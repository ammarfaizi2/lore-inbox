Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264835AbUEVC5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264835AbUEVC5I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264869AbUEVC5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 22:57:07 -0400
Received: from mail.kroah.org ([65.200.24.183]:32189 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264835AbUEVC5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 22:57:05 -0400
Date: Fri, 21 May 2004 19:56:23 -0700
From: Greg KH <greg@kroah.com>
To: Valdis.Kletnieks@vt.edu
Cc: Jon Smirl <jonsmirl@yahoo.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Exporting PCI ROMs via syfs
Message-ID: <20040522025623.GA15224@kroah.com>
References: <20040521010510.84867.qmail@web14928.mail.yahoo.com> <200405212338.i4LNcV8Z007967@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405212338.i4LNcV8Z007967@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2004 at 07:38:31PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 20 May 2004 18:05:10 PDT, Jon Smirl <jonsmirl@yahoo.com>  said:
> > GregKH has suggested that a good interface for accessing the contents of PCI
> > ROMs from user space would be to make them available from sysfs. What would be a
> > good way to structure the code for doing this? Should this be part of the pci
> > driver, and how would this interface into class_simple to make the attribute
> > appear?
> 
> Hmm... how do you make that fit with the "one file, one value" rule for sysfs?
> Have the "one value" be a nnnK binary blob representing the ROM image?

Exactly, just like the pci "config" file is in sysfs today.

thanks,

greg k-h
