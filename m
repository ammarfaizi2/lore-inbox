Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266085AbUGZVMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266085AbUGZVMY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 17:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265946AbUGZU5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 16:57:54 -0400
Received: from [66.35.79.110] ([66.35.79.110]:38574 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S266081AbUGZUqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 16:46:35 -0400
Date: Mon, 26 Jul 2004 13:44:57 -0700
From: Tim Hockin <thockin@hockin.org>
To: Greg KH <greg@kroah.com>
Cc: Oliver Neukum <oliver@neukum.org>, Robert Love <rml@ximian.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Andrew Morton <akpm@osdl.org>, cw@f00f.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-ID: <20040726204457.GA10970@hockin.org>
References: <F989B1573A3A644BAB3920FBECA4D25A6EBFB5@orsmsx407> <1090853403.1973.11.camel@localhost> <20040726161221.GC17449@kroah.com> <200407262013.33454.oliver@neukum.org> <20040726190305.GA19498@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726190305.GA19498@kroah.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 03:03:05PM -0400, Greg KH wrote:
> > On a related note, is this supposed to supersede the current hotplug
> > mechanism?
> 
> No, it will not.  At the most, it will report the same information to
> make it easier for userspace programs who want to get the other
> event information, also get the hotplug stuff through the same
> interface, reducing their complexity.
> 
> So the existing hotplug interface is not going away at all.  Do not even
> begin to think that :)

What about flipping it around and using either hotplug or a hotplug-like
mechanism for these events?

It solves the issue of events being dropped when there is no listening
daemon...

These are not going to be high-traffic messages, right, so the overhead is
negligible...
