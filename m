Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWHCUGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWHCUGL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWHCUGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:06:11 -0400
Received: from mx1.suse.de ([195.135.220.2]:39062 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030221AbWHCUGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:06:10 -0400
Date: Thu, 3 Aug 2006 13:01:36 -0700
From: Greg KH <greg@kroah.com>
To: Zachary Amsden <zach@vmware.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
Message-ID: <20060803200136.GB28537@kroah.com>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com> <44D24DD8.1080006@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D24DD8.1080006@vmware.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 12:26:16PM -0700, Zachary Amsden wrote:
> Greg KH wrote:
> >On Thu, Aug 03, 2006 at 03:14:21AM -0700, Zachary Amsden wrote:
> >  
> >>I would like to propose an interface for linking a GPL kernel, 
> >>specifically, Linux, against binary blobs.
> >>    
> >
> >Sorry, but we aren't lawyers here, we are programmers.  Do you have a
> >patch that shows what you are trying to describe here?  Care to post it?
> >  
> 
> <Posts kernel/module.c unmodified>

If you want to stick with the current kernel module interface, I don't
see why you even need to bring this up, there are no arguments about
that API being in constant flux :)

> >How does this differ with the way that the Xen developers are proposing?
> >Why haven't you worked with them to find a solution that everyone likes?
> >  
> 
> We want our backend to provide a greater degree of stability than a pure 
> source level API as the Xen folks have proposed.  We have tried to 
> convince them that an ABI is in their best interest, but they are 
> reluctant to commit to one or codesign one at this time.

Don't you feel it's a bit early to "commit" to anything yet when we
don't have a working implementation?  Things change over time, and it's
one of the main reasons Linux is so successful.

> >And what about Rusty's proposal that is supposed to be the "middle
> >ground" between the two competing camps?  How does this differ from
> >that?  Why don't you like Rusty's proposal?
> >  
> 
> Who said that?  Please smack them on the head with a broom.  We are all 
> actively working on implementing Rusty's paravirt-ops proposal.  It 
> makes the API vs ABI discussion moot, as it allow for both.

So everyone is still skirting the issue, oh great :)

> >Please, start posting code and work together with the other people that
> >are wanting to achive the same end goal as you are.  That is what really
> >matters here.
> >  
> 
> We have already started upstreaming patches.  Jeremy, Rusty and I have 
> or will send out sets yesterday / today.  We haven't been vocal on LKML, 
> as we'd just be adding noise.  We are working with Rusty and the Xen 
> developers, and you can see our patchset here:
> 
> http://ozlabs.org/~rusty/paravirt/?cl=tip
> 
> And follow our development discussions here:
> 
> http://lists.osdl.org/pipermail/virtualization/

I really don't want to follow the discussion unless necessary.  I trust
Chris and Rusty to do the right thing in this area...

thanks,

greg k-h
