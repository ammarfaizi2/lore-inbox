Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269380AbUICIcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269380AbUICIcL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 04:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269394AbUICIcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 04:32:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:16786 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269380AbUICIZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:25:58 -0400
Date: Fri, 3 Sep 2004 10:22:57 +0200
From: Greg KH <greg@kroah.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040903082256.GA17629@kroah.com>
References: <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com> <200408290004.i7T04DEO003646@localhost.localdomain> <20040901224513.GM31934@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901224513.GM31934@mail.shareable.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 11:45:13PM +0100, Jamie Lokier wrote:
> Horst von Brand wrote:
> > What happened to "code talks, bullshit walks"?
> 
> devfs is a fine example of why code isn't enough.  With devfs the code
> came first, the >1 year of strategic bullshit politics from the "it's
> not traditional unix" crowd came later, then it went in, then lots of
> people used it, then it was replaced by something which still doesn't
> work as well as 2.4 does with or without devfs, and people are still
> using it despite it's faults.

What is udev's faults that have an issue with?

Yes, we don't do module autoloading when opening a device node, but
that's well known, documented, and the way the kernel has evolved to
anyway.

thanks,

greg k-h
