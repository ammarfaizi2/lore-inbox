Return-Path: <linux-kernel-owner+w=401wt.eu-S1751151AbXANHxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbXANHxE (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 02:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbXANHxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 02:53:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:40000 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbXANHxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 02:53:03 -0500
Date: Sat, 13 Jan 2007 23:41:25 -0800
From: Greg KH <greg@kroah.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>, Jan Beulich <JBeulich@novell.com>
Subject: Re: [patch 18/20] XEN-paravirt: Add Xen driver utility functions.
Message-ID: <20070114074125.GB10585@kroah.com>
References: <20070113014539.408244126@goop.org> <20070113014649.046041214@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070113014649.046041214@goop.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 05:45:57PM -0800, Jeremy Fitzhardinge wrote:
> Allocate/destroy a 'vmalloc' VM area: alloc_vm_area and free_vm_area
> The alloc function ensures that page tables are constructed for the
> region of kernel virtual address space and mapped into init_mm.

Shouldn't these functions go into the core mm/ kernel code if they are
needed, instead of living in the xen directories?

thanks,

greg k-h
