Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263014AbVFWIIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbVFWIIz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbVFWIEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:04:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:2190 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262457AbVFWG0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:26:41 -0400
Date: Wed, 22 Jun 2005 23:26:27 -0700
From: Greg KH <greg@kroah.com>
To: Miles Bader <miles@gnu.org>
Cc: Mike Bell <kernel@mikebell.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-ID: <20050623062627.GB11638@kroah.com>
References: <20050621062926.GB15062@kroah.com> <20050620235403.45bf9613.akpm@osdl.org> <20050621151019.GA19666@kroah.com> <20050623010031.GB17453@mikebell.org> <20050623045959.GB10386@kroah.com> <buoaclhwqfj.fsf@mctpc71.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buoaclhwqfj.fsf@mctpc71.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 03:14:08PM +0900, Miles Bader wrote:
> Greg KH <greg@kroah.com> writes:
> > And again, for embedded systems, there are packages to build it and put
> > it in initramfs.  People have already done the work for you.
> 
> BTW, has anyone done a comparison of the space usage of udev vs. devfs
> (including size of code etc....)?

Not that I know of.  If you want to do this, compare the original udev
releases that were around 5kb of code, as the nice features it has today
are stuff that devfs can not support at all.

thanks,

greg k-h
