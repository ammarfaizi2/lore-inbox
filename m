Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbVCVE6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbVCVE6e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbVCVE0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 23:26:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:30176 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262375AbVCVETm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 23:19:42 -0500
Date: Mon, 21 Mar 2005 20:02:11 -0800
From: Greg KH <greg@kroah.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Jon Smirl <jonsmirl@gmail.com>
Subject: Re: current linus bk, error mounting root
Message-ID: <20050322040211.GB13745@kroah.com>
References: <9e47339105030909031486744f@mail.gmail.com> <20050321154131.30616ed0.akpm@osdl.org> <9e473391050321155735fc506d@mail.gmail.com> <20050321161925.76c37a7f.akpm@osdl.org> <5dab45539e663d50b9e3e5d05fc11336@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dab45539e663d50b9e3e5d05fc11336@mac.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 08:14:29PM -0500, Kyle Moffett wrote:
> On Mar 21, 2005, at 19:19, Andrew Morton wrote:
> >Jon Smirl <jonsmirl@gmail.com> wrote:
> >>Jens is right that this is a user space issue, but how many people are
> >>going to find this out the hard way when their root drives stop
> >>mounting. Since no one is complaining I have to assume that most
> >>kernel developers have their root device drivers built into the
> >>kernel. I was loading mine as a module since for a long time Redhat
> >>was not shipping kernels with SATA built in.
> >
> >I don't agree that this is a userspace issue.  It's just not sane for a
> >driver to be in an unusable state for an arbitrary length of time after
> >modprobe returns.
> 
> What about if I'm booting from a USB drive?

That's a different issue, as you stated.  There are other patches
floating around that address this.

thanks,

greg k-h
