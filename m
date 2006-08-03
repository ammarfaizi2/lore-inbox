Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWHCTkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWHCTkl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 15:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWHCTkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 15:40:41 -0400
Received: from mail.suse.de ([195.135.220.2]:13455 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030214AbWHCTkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 15:40:40 -0400
Date: Thu, 3 Aug 2006 12:36:00 -0700
From: Greg KH <greg@kroah.com>
To: Zachary Amsden <zach@vmware.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
Message-ID: <20060803193600.GA14858@kroah.com>
References: <44D1CC7D.4010600@vmware.com> <1154603822.2965.18.camel@laptopd505.fenrus.org> <44D23B84.6090605@vmware.com> <20060803190327.GA14237@kroah.com> <44D24B31.2080802@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D24B31.2080802@vmware.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 12:14:57PM -0700, Zachary Amsden wrote:
> Greg KH wrote:
> >On Thu, Aug 03, 2006 at 11:08:04AM -0700, Zachary Amsden wrote:
> >  
> >>Perhaps we can use this to encourage open sourced firmware layers,
> >>instead of trying to ban drivers which rely on firmware from the
> >>kernel.
> >>    
> >
> >No one is trying to ban such drivers.  Well, except the odd people on
> >debian-legal, but all the kernel developers know to ignore them :)
> >  
> 
> That is good to know.  But there is a kernel option which doesn't make 
> much sense in that case:
> 
> [*] Select only drivers that don't need compile-time external firmware

No, that is very different.  That option is present if you don't want to
build some firmware images from the source that is present in the kernel
tree, and instead, use the pre-built stuff that is also present in the
kernel tree.

It is there so that we do not require some additional tools that the
majority of kernel developers do not have installed on their machine in
order to create a working kernel image for some types of hardware.

Hope this helps,

greg k-h
