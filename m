Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266028AbUFDWsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266028AbUFDWsK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 18:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266024AbUFDWsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 18:48:09 -0400
Received: from mail.kroah.org ([65.200.24.183]:26568 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266030AbUFDWre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 18:47:34 -0400
Date: Fri, 4 Jun 2004 13:43:22 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Zabolotny <zap@homelink.ru>, Todd Poynor <tpoynor@mvista.com>,
       linux-kernel@vger.kernel.org
Subject: Re: two patches - request for comments
Message-ID: <20040604204322.GA13569@kroah.com>
References: <20040529012030.795ad27e.zap@homelink.ru> <40B7B659.9010507@mvista.com> <20040529121059.3789c355.zap@homelink.ru> <40BCE28A.1050601@mvista.com> <20040602010036.440fc5b4.zap@homelink.ru> <20040602171542.GL7829@kroah.com> <20040602223219.B9322@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602223219.B9322@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 10:32:19PM +0100, Russell King wrote:
> On Wed, Jun 02, 2004 at 10:15:42AM -0700, Greg KH wrote:
> > On Wed, Jun 02, 2004 at 01:00:36AM +0400, Andrew Zabolotny wrote:
> > > 
> > > In theory, if we would use the standard power interface, it could use the
> > > different levels of power saving, e.g. 0 - controller and LCD on, 1,2 - LCD
> > > off, controller on, 3,4 - both off.
> > 
> > Please use the standard power interface, and use the standard levels of
> > power state.  That's why we _have_ this driver model in the first
> > place...
> 
> It /doesn't/ make any sense to in this case.  We're talking effectively
> about the LCD panel attributes, not a device as such.

<snip>

> Hope this provides some extra reasoning why using the device model
> for these attributes is wrong.

Ok, this makes more sense now, thanks for explaining it.

greg k-h
