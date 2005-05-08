Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbVEHA4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbVEHA4f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 20:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVEHA4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 20:56:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61385 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262772AbVEHA4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 20:56:33 -0400
Date: Sat, 7 May 2005 17:56:30 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Extremely poor umass transfer rates
Message-Id: <20050507175630.46b04ce3.zaitcev@redhat.com>
In-Reply-To: <mailman.1115308386.9411.linux-kernel2news@redhat.com>
References: <3YjKy-72a-21@gated-at.bofh.it>
	<3YkGD-7NT-15@gated-at.bofh.it>
	<3Ylt2-8mA-7@gated-at.bofh.it>
	<3YlWb-px-35@gated-at.bofh.it>
	<3YCkl-5lB-21@gated-at.bofh.it>
	<4273E5B3.6040708@shaw.ca>
	<d4757e6005050420133ecd39c6@mail.gmail.com>
	<mailman.1115308386.9411.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 1.9.9 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2005 01:22:50 -0700, Greg KH <greg@kroah.com> wrote:
> On Wed, May 04, 2005 at 11:13:55PM -0400, Joe wrote:
> > Something is definetly going on with either vfat or the USB drivers...
> > My ipod is unrunnable on linux now.  To put it plainly, it transfers
> > painfully slow (on USB 2.0 mind you), it randomly ceases to respond
> > during file transfers.. and will only respond if replugged in.. its
> > corrupted my music and the fs to the point where i've now done two
> > low-level formats, and every time i put the stuff back on, the same
> > problems persist.
> 
> Are you using the ub or usb-storage driver?

Joe's symptoms are not consistent with ub. I use ub with my iPod, it works
just fine, only somewhat slow (my partition size on iPod is a multiply
of 4KB, so it only loses speed because of external fragmentation).
I suspect Jor has cabling problems or something like that.

If anyone observes data integrity issues with ub, I need to know
right away.

-- Pete
