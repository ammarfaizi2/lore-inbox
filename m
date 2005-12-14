Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965106AbVLNXnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbVLNXnU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbVLNXnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:43:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:31127 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965106AbVLNXnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:43:18 -0500
Date: Wed, 14 Dec 2005 15:42:55 -0800
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, katzj@redhat.com
Subject: Re: "block" symlink in sysfs for a multifunction device
Message-ID: <20051214234255.GA3275@kroah.com>
References: <20051212134904.225dcc5d.zaitcev@redhat.com> <20051214055019.GA23036@kroah.com> <20051214152615.13b6b105.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214152615.13b6b105.zaitcev@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 03:26:15PM -0800, Pete Zaitcev wrote:
> On Tue, 13 Dec 2005 21:50:19 -0800, Greg KH <greg@kroah.com> wrote:
> 
> > $ ls -l /sys/block/uba/device/
> > -r--r--r--  1 root root 4096 Dec 13 21:31 bNumEndpoints
> > lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:uba -> ../../../../../../block/uba
> > lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:ubb -> ../../../../../../block/ubb
> > lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:ubc -> ../../../../../../block/ubc
> > lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:ubd -> ../../../../../../block/ubd
> 
> Greg, Jeremy is not happy about this.
> 
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=175563
> > ------- Additional Comments From katzj@redhat.com  2005-12-14 18:05 EST -------
> > Actually, this is problematic.  It makes it so that the single device directory
> > corresponds to more than one device which we can't handle with kudzu :-(

Well, how do you handle it for class devices then?

And if this isn't acceptable, what would be?

Just because kudzu is messed up... :)

thanks,

greg k-h
