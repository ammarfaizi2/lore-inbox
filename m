Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267879AbUBRTRp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 14:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267880AbUBRTRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 14:17:44 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:12263 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267879AbUBRTRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 14:17:36 -0500
Date: Wed, 18 Feb 2004 11:17:30 -0800
From: Greg KH <gregkh@us.ibm.com>
To: Linda Xie <lxiep@linux.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, John Rose <johnrose@austin.ibm.com>,
       Rusty Russell <rusty@au1.ibm.com>, linux-kernel@vger.kernel.org,
       Mike Wortman <wortman@us.ibm.com>
Subject: Re: [PATCH] PPC64 PCI Hotplug Driver for RPA
Message-ID: <20040218191729.GA3254@us.ibm.com>
References: <20040215222211.4F99817DE7@ozlabs.au.ibm.com> <1076955716.10484.21.camel@verve.austin.ibm.com> <20040216183514.A19426@infradead.org> <4033B983.6060809@ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4033B983.6060809@ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.3 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 01:14:11PM -0600, Linda Xie wrote:
> >
> >If you have a method that per specification doesn't get a NULL pointer 
> >adding
> >these kinds of checks is bad.  Getting a NULL pointer would be against the
> >codified guaranteeds and your system already is bad trouble - better panic
> >ASAP by dereferencing the NULL pointer than waiting longer and possibly
> >corrupting data.
> > 
> >
> Well, I understand your point, but other php drivers do the same thing.
> 
> Greg,
> Any thoughts?

I was being overly cautious a long time ago when I wrote that code.
Actually the whole "magic number" stuff can go away too, as that's
pretty pointless...

But don't worry about that too much.  If you want to clean it up, I
don't care.

> updated patch attached.

Um, how about a whole new patch against 2.6.3 as I have not applied this
one...

thanks,

greg k-h
