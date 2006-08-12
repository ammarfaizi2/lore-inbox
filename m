Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWHLEfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWHLEfO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 00:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWHLEfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 00:35:14 -0400
Received: from imf21aec.mail.bellsouth.net ([205.152.59.69]:28129 "EHLO
	imf21aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S1751306AbWHLEfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 00:35:12 -0400
Subject: Re: Status of driver core struct device changes?
From: Louis Garcia II <louisg00@bellsouth.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060812005959.GA25689@kroah.com>
References: <1155332969.2652.8.camel@soncomputer>
	 <20060812005959.GA25689@kroah.com>
Content-Type: text/plain
Date: Sat, 12 Aug 2006 00:34:43 -0400
Message-Id: <1155357283.19292.3.camel@soncomputer>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 (2.7.91-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-11 at 17:59 -0700, Greg KH wrote:
> On Fri, Aug 11, 2006 at 05:49:29PM -0400, Louis Garcia II wrote:
> > A couple of months ago greg kh started work toward allowing everything
> > to be a struct device in the sysfs device tree. How is this progressing?
> 
> Quite well.  But next time you might want to CC: me as I almost missed
> this message.
> 
> > Any time frame when we will have a simplified driver core api?
> 
> It's getting there.  If you look in -mm there are a lot of subsystems
> already converted over, along with a lot of patches from andrew that
> revert these changes due to udev issues.
> 
> I'm working on fixing up the udev issues so that the kernel work is not
> held up.  That's a bit slower going as it requires me to install a lot
> of different distros...
> 
> thanks,
> 
> greg k-h

How about block devices? Will it be moved to /sys/class or is that abi
set in stone?

-Louis

