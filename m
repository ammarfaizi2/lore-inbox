Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268129AbUJJExa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268129AbUJJExa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 00:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268128AbUJJExa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 00:53:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:22235 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268120AbUJJExA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 00:53:00 -0400
Date: Sat, 9 Oct 2004 21:29:58 -0700
From: Greg KH <greg@kroah.com>
To: Dave Airlie <airlied@linux.ie>
Cc: Jon Smirl <jonsmirl@gmail.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [patch] drm core internal versioning..
Message-ID: <20041010042958.GA28025@kroah.com>
References: <Pine.LNX.4.58.0410100050160.6083@skynet> <9e47339104100917527993026d@mail.gmail.com> <Pine.LNX.4.58.0410100328080.11219@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410100328080.11219@skynet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2004 at 03:31:26AM +0100, Dave Airlie wrote:
> 
> I don't want to re-implement kernel modversions which is what we are close
> to doing

Then why not just rely on the modversion code in the kernel tree to do
this?  As you say:

> you can't insmod a module built against a different kernel
> anyways so it doesn't matter, kernel version, preempt, smp, compiler are
> all checked on insmod in 2.6 if they don't match it doesn't load it is not
> possible to distrib a binarry kernel independent module..

Which is a pretty good reason not to try to implement your own
versioning system, right?

> without at least a portable stub source loader...

Are you thinking that someone will try to do this?  If so, they deserve
what they get :)

thanks,

greg k-h
