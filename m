Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWEIQS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWEIQS7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWEIQS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:18:59 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:54686 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1751263AbWEIQS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:18:58 -0400
Date: Tue, 9 May 2006 17:18:50 +0100
From: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 03/35] Add Xen interface header files
Message-ID: <20060509161850.GK7834@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <20060509085147.903310000@sous-sol.org> <1147190772.21536.30.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147190772.21536.30.camel@c-67-180-134-207.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 09:06:12AM -0700, Daniel Walker wrote:
> On Tue, 2006-05-09 at 00:00 -0700, Chris Wright wrote:
> > plain text document attachment (xen-interface-headers)
> > Add Xen interface header files. These are taken fairly directly from
> > the Xen tree and hence the style is not entirely in accordance with
> > Linux guidelines. There is a tension between fitting with Linux coding
> > rules and ease of maintenance.
> > 
> > Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
> > Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> > Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> > ---
> >  include/xen/interface/arch-x86_32.h   |  197 +++++++++++++++
> >  include/xen/interface/event_channel.h |  205 +++++++++++++++
> >  include/xen/interface/features.h      |   53 ++++
> >  include/xen/interface/grant_table.h   |  311 +++++++++++++++++++++++
> >  include/xen/interface/io/blkif.h      |   85 ++++++
> 
> Shouldn't these be under asm-i386 , or are they used by other
> architecture ? 

The full set of interface headers supports several architectures.

I think having all the header files in one place is preferable,
but will gladly move them wherever is agreed on to be best ;-)

    christian

