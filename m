Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUAWSSm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266632AbUAWSSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:18:41 -0500
Received: from mail.kroah.org ([65.200.24.183]:20907 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262960AbUAWSSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:18:34 -0500
Date: Fri, 23 Jan 2004 10:18:30 -0800
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and platform_device_unregister_wait() to the driver model core
Message-ID: <20040123181830.GE23169@kroah.com>
References: <Pine.LNX.4.58.0401230939170.2151@home.osdl.org> <Pine.LNX.4.44L0.0401231248510.856-100000@ida.rowland.org> <20040123181004.GJ21151@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123181004.GJ21151@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 06:10:04PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Fri, Jan 23, 2004 at 01:03:33PM -0500, Alan Stern wrote:
> > The general context is that a module is trying to unload, but it can't
> > until the release() callback for its device has finished.
> 
> ... and if I redirect rmmod stdin from sysfs, we get what?  Exactly.

You get what you deserve :)
