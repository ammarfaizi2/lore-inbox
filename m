Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751658AbVJ1TLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbVJ1TLo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 15:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbVJ1TLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 15:11:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:42426 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751658AbVJ1TLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 15:11:43 -0400
Date: Fri, 28 Oct 2005 12:11:07 -0700
From: Greg KH <greg@kroah.com>
To: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Driver Core patches for 2.6.14
Message-ID: <20051028191107.GB16822@kroah.com>
References: <20051028062921.GA6397@kroah.com> <20051028174812.GA15637@kroah.com> <20051028185530.GN27184@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051028185530.GN27184@lug-owl.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 08:55:30PM +0200, Jan-Benedict Glaw wrote:
> On Fri, 2005-10-28 10:48:12 -0700, Greg KH <gregkh@suse.de> wrote:
> > Please pull from:
> > 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
> > or if master.kernel.org hasn't synced up yet:
> > 	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
> > 
> > Below is the diffstat and shortlog of the changes.
> 
> >  drivers/input/keyboard/lkkbd.c                 |  126 ++---
> 
> Not ACKed.  This patch contains a not-fixed (though reported) wrong
> printk format in lkkbd_interrupt() "case LK_METRONOME:" Though I
> haven't tested it yet, it's ACKed by me after this is fixed.

That can be a one-line add on patch once it is created.  I can easily
send that later.

thanks,

greg k-h
