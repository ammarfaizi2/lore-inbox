Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161087AbWHDHVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbWHDHVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 03:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbWHDHVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 03:21:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40861 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161087AbWHDHVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 03:21:39 -0400
Date: Fri, 4 Aug 2006 00:21:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: jeremy@xensource.com, greg@kroah.com, zach@vmware.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       jlo@vmware.com, xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com, jeremy@goop.org
Subject: Re: A proposal - binary
Message-Id: <20060804002107.c0f9ba25.akpm@osdl.org>
In-Reply-To: <1154675100.11382.47.camel@localhost.localdomain>
References: <44D1CC7D.4010600@vmware.com>
	<20060803190605.GB14237@kroah.com>
	<44D24DD8.1080006@vmware.com>
	<20060803200136.GB28537@kroah.com>
	<44D2B678.6060400@xensource.com>
	<20060803211850.3a01d0cc.akpm@osdl.org>
	<1154667875.11382.37.camel@localhost.localdomain>
	<20060803225357.e9ab5de1.akpm@osdl.org>
	<1154675100.11382.47.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Aug 2006 17:04:59 +1000
Rusty Russell <rusty@rustcorp.com.au> wrote:

> On Thu, 2006-08-03 at 22:53 -0700, Andrew Morton wrote:
> > On Fri, 04 Aug 2006 15:04:35 +1000
> > Rusty Russell <rusty@rustcorp.com.au> wrote:
> > 
> > > On Thu, 2006-08-03 at 21:18 -0700, Andrew Morton wrote:
> > > Everywhere in the kernel where we have multiple implementations we want
> > > to select at runtime, we use an ops struct.  Why should the choice of
> > > Xen/VMI/native/other be any different?
> > 
> > VMI is being proposed as an appropriate way to connect Linux to Xen.  If
> > that is true then no other glue is needed.
> 
> Sorry, this is wrong.

It's actually 100% correct.

>  VMI was proposed as the appropriate way to
> connect Linux to Xen, *and* native, *and* VMWare's hypervisors (and
> others).  This way one Linux binary can boot on all three, using
> different VMI blobs.

That also is correct.
 
> > > Yes, we could force native and Xen to work via VMI, but the result would
> > > be less clear, less maintainable, and gratuitously different from
> > > elsewhere in the kernel.
> > 
> > I suspect others would disagree with that.  We're at the stage of needing
> > to see code to settle this.
> 
> Wrong again.

I was referring to the VMI-for-Xen code.

>  We've *seen* the code for VMI, and fairly hairy.

I probably slept through that discussion - I don't recall that things were
that bad.   Do you recall the Subject: or date?


