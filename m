Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269394AbUICIfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269394AbUICIfP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 04:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269372AbUICIcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 04:32:52 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:50341 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269394AbUICIcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:32:12 -0400
Message-ID: <2f4958ff04090301326e7302c1@mail.gmail.com>
Date: Fri, 3 Sep 2004 10:32:07 +0200
From: =?UTF-8?Q?Grzegorz_Ja=C5=9Bkiewicz?= <gryzman@gmail.com>
Reply-To: =?UTF-8?Q?Grzegorz_Ja=C5=9Bkiewicz?= <gryzman@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: silent semantic changes with reiser4
Cc: Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <20040903082256.GA17629@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com> <200408290004.i7T04DEO003646@localhost.localdomain> <20040901224513.GM31934@mail.shareable.org> <20040903082256.GA17629@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004 10:22:57 +0200, Greg KH <greg@kroah.com> wrote:
> On Wed, Sep 01, 2004 at 11:45:13PM +0100, Jamie Lokier wrote:
> > Horst von Brand wrote:
> > > What happened to "code talks, bullshit walks"?
> >
> > devfs is a fine example of why code isn't enough.  With devfs the code
> > came first, the >1 year of strategic bullshit politics from the "it's
> > not traditional unix" crowd came later, then it went in, then lots of
> > people used it, then it was replaced by something which still doesn't
> > work as well as 2.4 does with or without devfs, and people are still
> > using it despite it's faults.
> 
> What is udev's faults that have an issue with?
> 
> Yes, we don't do module autoloading when opening a device node, but
> that's well known, documented, and the way the kernel has evolved to
> anyway.

devfs was very natural, and simple solution. But to have it right, it
would have to be the only /dev filesystem.
But no, we like choices, so we have chaos. 
Udev is just another thing adding to that chaos.

Someone was numbering things that are good in BSD design, in that
thread. One of those things was going for devfs. No cheap solutions.
One fs for /dev. And it works great.

Sorry for bit of trolling.

-- 
GJ
