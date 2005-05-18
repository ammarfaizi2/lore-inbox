Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVERQzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVERQzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVERQvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:51:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:39336 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262302AbVERQpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 12:45:55 -0400
Date: Wed, 18 May 2005 09:51:48 -0700
From: Greg KH <greg@kroah.com>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux.bkbits.net question: mapping cset to kernel version?
Message-ID: <20050518165148.GC17307@kroah.com>
References: <428B4D14.2030104@ammasso.com> <20050518160930.GA16756@kroah.com> <428B6BF8.2010303@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428B6BF8.2010303@ammasso.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 11:23:20AM -0500, Timur Tabi wrote:
> Greg KH wrote:
> 
> >But that's how you have to do it, sorry.  You have the patches, why
> >can't you just use grep?  :)
> 
> What does Linus do to keep track of these changes?  Granted, he's not using 
> BitKeeper any more, but it does support release management, so I would 
> presume he was tagging the releases with it.

Yes, and that tagging worked just fine.  You can see this too if you
want to check out a tree based on a tag.

> What does he do now?

Uses git, which will have the same issues as you are facing :)

Please remeber, with a distributed development system like this, going
off of the "date" means _nothing_.  What matters is when that patch and
branch is merged into his tree, and to determine that, you will have to
dig around a bit.

And since you have raw patches, and know what you are looking for, the
solution should be very simple (hint, grep...)

Good luck,

greg k-h
