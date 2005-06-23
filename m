Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVFWITW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVFWITW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262863AbVFWIQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:16:32 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:14513 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262284AbVFWHDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 03:03:22 -0400
Date: Thu, 23 Jun 2005 00:03:09 -0700
From: Greg KH <gregkh@suse.de>
To: snogglethorpe@gmail.com, miles@gnu.org
Cc: Greg KH <greg@kroah.com>, Mike Bell <kernel@mikebell.org>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-ID: <20050623070309.GA12158@suse.de>
References: <20050621062926.GB15062@kroah.com> <20050620235403.45bf9613.akpm@osdl.org> <20050621151019.GA19666@kroah.com> <20050623010031.GB17453@mikebell.org> <20050623045959.GB10386@kroah.com> <buoaclhwqfj.fsf@mctpc71.ucom.lsi.nec.co.jp> <20050623062627.GB11638@kroah.com> <fc339e4a05062223365c2a5ed5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc339e4a05062223365c2a5ed5@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 03:36:11PM +0900, Miles Bader wrote:
> On 6/23/05, Greg KH <greg@kroah.com> wrote:
> > Not that I know of.  If you want to do this, compare the original udev
> > releases that were around 5kb of code, as the nice features it has today
> > are stuff that devfs can not support at all.
> 
> That wouldn't be such an effective tool for convincing people to
> switch though... :-)  "Look this obsolete version is much smaller!"
> 
> If udev has really bloated up due to whizzy new features, how hard
> would it be to compile a stripped-down version?  [Well I should look
> at the busybox support somebody mentioned -- perhaps it's exactly
> that.]

It wouldn't be that hard at all, just look at the first couple of
releases for example code to use (you would want it to be a totally
separate project, the current udev is not ment for such a stripped down
thing, it's ment to take over all of the /sbin/hotplug funcionality,
through netlink no less.)

thanks,

greg k-h
