Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbULUQWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbULUQWu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 11:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbULUQWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 11:22:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:29420 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261783AbULUQWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 11:22:49 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI API to sysfs
Date: Tue, 21 Dec 2004 08:22:35 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, willy@debian.org
References: <200412201450.47952.jbarnes@engr.sgi.com> <20041220225817.GA21404@kroah.com> <1103613004.21771.25.camel@gaston>
In-Reply-To: <1103613004.21771.25.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412210822.35949.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, December 20, 2004 11:10 pm, Benjamin Herrenschmidt wrote:
> > > +static int mmap(struct file *file, struct vm_area_struct *vma)
> > > +{
>
> Also, just a style comment: I dislike when functions have such a
> "generic" name like mmap. I'd _much_ prefer something like pcisysfs_mmap
> or something like that. The simple name makes it confusing in
> System.map/kallsyms and thus when debugging.

True, but I was just following the convention in bin.c.  Maybe that could be 
cleaned up all at once with a separate patch?  There's some whitespace I'd 
like to cleanup in pci-sysfs.c as well, so I could do both at once.

Jesse
