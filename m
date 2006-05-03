Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWECWMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWECWMb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 18:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWECWMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 18:12:31 -0400
Received: from mx1.suse.de ([195.135.220.2]:949 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751379AbWECWMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 18:12:30 -0400
Date: Wed, 3 May 2006 15:10:37 -0700
From: Greg KH <greg@kroah.com>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, ioe-lkml@rameria.de,
       joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com, penberg@cs.helsinki.fi
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060503221037.GA17181@kroah.com>
References: <20060429011423.7db4075a.akpm@osdl.org> <OF10257691.2976B094-ON42257163.00301DAA-42257163.00305E96@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF10257691.2976B094-ON42257163.00301DAA-42257163.00305E96@de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2006 at 10:48:19AM +0200, Michael Holzheu wrote:
> Hi Andrew,
> 
> Andrew Morton <akpm@osdl.org> wrote on 04/29/2006 10:14:23 AM:
> 
> [snip]
> 
> > >  > Also, "/sys/hypervisor" is probably insufficiently specific.  In a
> few
> > >  > years time people will be asking "Which hypervisor?  We have
> > eighteen of them!".
> > >
> > >  I agree, the xen people are already clammering for some kind of sysfs
> > >  tree and wanted to create /sys/hypervisor/xen.  How about
> > >  /sys/hypervisor/s390?
> 
> Fine with me! Then I will create /sys/hypervisor/s390. Should I
> create /sys/hypervisor in the hpyfs code or should it be
> created somewhere else?

Somewhere else is probably best.

drivers/base/hypervisor.c ?

thanks,

greg k-h
