Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbUCJXCv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 18:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbUCJXCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 18:02:51 -0500
Received: from mail.kroah.org ([65.200.24.183]:31451 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262883AbUCJW6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 17:58:16 -0500
Date: Wed, 10 Mar 2004 14:52:37 -0800
From: Greg KH <greg@kroah.com>
To: rihad <rihad@mail.ru>
Cc: linux-kernel-digest@lists.us.dell.com, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040310225237.GE24336@kroah.com>
References: <20040303153403.21649.81059.Mailman@linux.us.dell.com> <4048D503.10808@mail.ru> <20040309081948.GI22057@kroah.com> <404D9966.6080903@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404D9966.6080903@mail.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 02:16:06PM +0400, rihad wrote:
> 
> Does the devfs/udev /dev entry get removed when doing rmmod? I though 
> not.

Yes it does.  If the sysfs entry goes away.

> But since the module isn't there anymore, doing mount /dev/cdrom 
> /cdrom would give "No such device". Not a problem per se, but then 
> probably rmmod -a isn't as a wise thing to do with udev as it is with 
> devfs. Bad.

rmmod -a has not been a wise thing to do since 2.2 came out.  It can
easily take down a working box...

thanks,

greg k-h
