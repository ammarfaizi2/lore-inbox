Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268209AbUIKQ6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268209AbUIKQ6a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 12:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268204AbUIKQ6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 12:58:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:43146 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268209AbUIKQ5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 12:57:13 -0400
Date: Sat, 11 Sep 2004 09:56:45 -0700
From: Greg KH <greg@kroah.com>
To: Tim Hockin <thockin@hockin.org>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Robert Love <rml@ximian.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040911165645.GA17099@kroah.com>
References: <20040902083407.GC3191@kroah.com> <1094142321.2284.12.camel@betsy.boston.ximian.com> <20040904005433.GA18229@kroah.com> <1094353088.2591.19.camel@localhost> <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org> <20040910235409.GA32424@kroah.com> <20040911001849.GA321@hockin.org> <20040911004827.GA8139@kroah.com> <20040911014543.GA5053@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911014543.GA5053@hockin.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 06:45:43PM -0700, Tim Hockin wrote:
> On Fri, Sep 10, 2004 at 05:48:27PM -0700, Greg KH wrote:
> > need be.  This keeps the kernel interface much simpler, and doesn't
> > allow you to abuse it for things it is not intended for (like error
> > reporting stuff...)
> 
> Errm, not for error reporting?  So the "driver hardening" and fault
> logging people shouldn't use this?

The "driver hardening" people hopefully have been scared away from Linux
so they never show their face around here again.  And if they do, no,
this is not what they want to do (what they need to do is get a clue...)

The fault logging people should also not use this, as this is for
notifying userspace that an event has happened.  And yes, "overheat" is
an example of a event that some people consider a "fault" :)

thanks,

greg k-h
