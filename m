Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbTFTKK5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 06:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTFTKK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 06:10:57 -0400
Received: from ns.suse.de ([213.95.15.193]:62724 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262703AbTFTKK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 06:10:56 -0400
Date: Fri, 20 Jun 2003 12:24:55 +0200
From: Andi Kleen <ak@suse.de>
To: Fruhwirth Clemens <clemens-dated-1056968093.cf44@endorphin.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initial Vector Fix for loop.c.
Message-ID: <20030620102455.GC26678@wotan.suse.de>
References: <20030620090612.GA1322@ghanima.endorphin.org.suse.lists.linux.kernel> <p73u1al3xlw.fsf@oldwotan.suse.de> <20030620101452.GA2233@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030620101452.GA2233@ghanima.endorphin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 12:14:52PM +0200, Fruhwirth Clemens wrote:
> On Fri, Jun 20, 2003 at 11:30:03AM +0200, Andi Kleen wrote:
> > Fruhwirth Clemens <clemens-dated-1056963973.bf26@endorphin.org> writes:
> > 
> > > So go for it. Fix it before 2.6.x is out and we're stuck with this crap
> > > again. 
> > 
> > This will break existing crypto loop installations, making
> > the existing encrypted image unreadable. After all this is Linux
> > here, not HackOS where you can break user file system formats at will.
> > The only way to implement this is with a new flag that is set by losetup
> > and keep the old behaviour by default.
> 
> There is no cryptoloop installation which is affected by this. Read my mail
> properly. Every cryptoloop setup out there uses loop-AES or kerneli's
> patch-int. And both fixed this issue a _long_ time ago. (Have a look at

That's completely wrong. I know of several independent implementation
and installations.

> Again: _no_ userbase is affected by this change. Every userbase which
> could have ever been affected has done the fix for itself.

That's also incorrect.

-Andi
