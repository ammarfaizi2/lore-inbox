Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWIASXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWIASXd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 14:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWIASXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 14:23:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:22425 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750722AbWIASXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 14:23:33 -0400
Date: Fri, 1 Sep 2006 11:16:58 -0700
From: Greg KH <gregkh@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Matt Porter <mporter@embeddedalley.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
Message-ID: <20060901181658.GE1322@suse.de>
References: <20060830062338.GA10285@kroah.com> <20060830143410.GB19477@gate.crashing.org> <p73pseh582x.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73pseh582x.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 03:49:10PM +0200, Andi Kleen wrote:
> Matt Porter <mporter@embeddedalley.com> writes:
> > 
> > What about portable access to the PCI DMA API from userspace? 
> 
> We'll definitely need this for X11 anyways. Currently it is not
> possible to run the standard X server with a IOMMU that isolates
> the graphics card because it has no way to get at the GPU MMIO
> registers then.
> 
> My long-term plan was to integrate it in /sys/bus/pci mmaps
> (together with PAT etc.). When you mmap it there the kernel
> allocates a DMA mapping and then frees it on unmap.

That sounds very reasonable, looking forward to it.

thanks,

greg k-h
