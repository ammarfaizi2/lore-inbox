Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWEITtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWEITtk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWEITtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:49:40 -0400
Received: from ns.suse.de ([195.135.220.2]:59067 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750997AbWEITtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:49:39 -0400
Date: Tue, 9 May 2006 12:48:02 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Jan Beulich <JBeulich@novell.com>
Subject: Re: [RFC PATCH 32/35] Add Xen driver utility functions.
Message-ID: <20060509194802.GA671@kroah.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085200.309814000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509085200.309814000@sous-sol.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 12:00:32AM -0700, Chris Wright wrote:
> +EXPORT_SYMBOL_GPL(alloc_vm_area);

> +EXPORT_SYMBOL_GPL(free_vm_area);

> +EXPORT_SYMBOL_GPL(lock_vm_area);

> +EXPORT_SYMBOL_GPL(unlock_vm_area);

These are all pretty generic function names.  Perhaps they belong in the
core kernel code instead of a Xen specific file?

thanks,

greg k-h
