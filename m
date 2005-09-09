Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030906AbVIIXCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030906AbVIIXCF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 19:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030907AbVIIXCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 19:02:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:24482 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030906AbVIIXCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 19:02:01 -0400
Date: Fri, 9 Sep 2005 15:54:21 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, davej@codemonkey.org.uk,
       arjan@infradead.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
Message-ID: <20050909225421.GA31433@suse.de>
References: <20050909220758.GA29746@kroah.com> <Pine.LNX.4.58.0509091535180.3051@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509091535180.3051@g5.osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 03:37:16PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 9 Sep 2005, Greg KH wrote:
> > 
> > Dave Jones:
> >   must_check attributes for PCI layer.
> 
> Why?

This is something that David and Arjan wanted in.  Guys?

> This only clutters up the compile, hiding real errors.
> 
> I think all those compile warnings are totally bogus. Who really cares? 
> Are they going to be fixed, or were they added just to irritate people?

I fixed up all of the PCI core and USB drivers that were flagged by
these warnings already.  Biggest area left is network drivers that I
saw.

> We should have a strict rule: anybody who adds things like "must_check"
> and "deprecated" had better also be ready and willing to fix all the new
> warnings they cause - you're not allowed to just assume that "somebody
> else will fix it".

Fair enough.  Dave and Arjan, want to fix up the rest of the tree?

thanks,

greg k-h
