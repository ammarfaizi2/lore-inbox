Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266141AbTLIIfy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 03:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266144AbTLIIfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 03:35:54 -0500
Received: from mail.kroah.org ([65.200.24.183]:7382 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266141AbTLIIfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 03:35:40 -0500
Date: Mon, 8 Dec 2003 23:56:20 -0800
From: Greg KH <greg@kroah.com>
To: Witukind <witukind@nsbm.kicks-ass.org>
Cc: recbo@nishanet.com, linux-kernel@vger.kernel.org
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Message-ID: <20031209075619.GA1698@kroah.com>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <3FD4CC7B.8050107@nishanet.com> <20031208233755.GC31370@kroah.com> <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 06:17:28AM +0100, Witukind wrote:
> From the udev FAQ:
> 
> Q: But udev will not automatically load a driver if a /dev node is opened
>    when it is not present like devfs will do.
> A: If you really require this functionality, then use devfs.  It is still
>    present in the kernel.
> 
> Will it have this 'equivalent functionality' some day?

Heh, no.  I really don't believe all of the people who keep asking me
this.  I think I need to reword this answer to something like:
  A:  That is correct.  If you really require this functionality, then
      use devfs.  There is no way that udev can support this, and it
      never will.

That better?  :)

thanks,

greg k-h
