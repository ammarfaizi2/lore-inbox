Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268174AbUIKQyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268174AbUIKQyo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 12:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268204AbUIKQyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 12:54:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:51081 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268174AbUIKQym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 12:54:42 -0400
Date: Sat, 11 Sep 2004 09:53:00 -0700
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@ximian.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040911165300.GA17028@kroah.com>
References: <20040831150645.4aa8fd27.akpm@osdl.org> <1093989924.4815.56.camel@betsy.boston.ximian.com> <20040902083407.GC3191@kroah.com> <1094142321.2284.12.camel@betsy.boston.ximian.com> <20040904005433.GA18229@kroah.com> <1094353088.2591.19.camel@localhost> <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org> <20040910235409.GA32424@kroah.com> <1094875775.10625.5.camel@lucy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094875775.10625.5.camel@lucy>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 12:09:35AM -0400, Robert Love wrote:
> > +/**
> > + * send_uevent - notify userspace by sending event trough netlink socket
> 
> s/trough/through/ ;-)

Heh, give something for the "spelling nit-pickers" to submit a patch
against :)

> We should probably add at least _some_ user.  The filesystem mount
> events are good, since we want to add those to HAL.

True, anyone want to send me a patch with a user of this?

thanks,

greg k-h
