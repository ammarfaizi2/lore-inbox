Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933196AbWFXCsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933196AbWFXCsZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 22:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933206AbWFXCsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 22:48:25 -0400
Received: from ns2.suse.de ([195.135.220.15]:55729 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S933196AbWFXCsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 22:48:24 -0400
Date: Fri, 23 Jun 2006 19:45:13 -0700
From: Greg KH <greg@kroah.com>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Greg KH <gregkh@suse.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 64bit resources start end value fix
Message-ID: <20060624024513.GB29637@kroah.com>
References: <20060621172903.GC9423@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621172903.GC9423@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 01:29:03PM -0400, Vivek Goyal wrote:
> Hi Greg,
> 
> While changing 64bit kconfig options to CONFIG_RESOURCES_64BIT, I forgot
> to update the values of start and end fields in ioport_resource and
> iomem_resource.
> 
> Following patch applies on top of your reworked 64 bit patches and
> is based on Andrew Morton's patch. Please apply.
> 
> http://marc.theaimsgroup.com/?l=linux-mm-commits&m=115087406130723&w=2

Ok, I think I have this finally all straigned out.  Can you look at my
quilt tree to verify that I've tweaked everything properly based on
this, and the other cleanup patches you and Andrew have been sending me
recently?

thanks,

greg k-h
