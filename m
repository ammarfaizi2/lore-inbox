Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUC3XIr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUC3XFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:05:14 -0500
Received: from mail.kroah.org ([65.200.24.183]:40626 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261661AbUC3XD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 18:03:26 -0500
Date: Tue, 30 Mar 2004 15:01:42 -0800
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, stern@rowland.harvard.edu,
       david-b@pacbell.net, viro@math.psu.edu,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Unregistering interfaces
Message-ID: <20040330230142.GA13571@kroah.com>
References: <20040328063711.GA6387@kroah.com> <Pine.LNX.4.44L0.0403281057100.17150-100000@netrider.rowland.org> <20040328123857.55f04527.akpm@osdl.org> <20040329210219.GA16735@kroah.com> <20040329132551.23e12144.akpm@osdl.org> <20040329231604.GA29494@kroah.com> <20040329153117.558c3263.akpm@osdl.org> <20040330055135.GA8448@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330055135.GA8448@in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 11:21:35AM +0530, Maneesh Soni wrote:
>                                                                                 
> I am not very clear about how the first two behave. Still I can think
> of a solution within sysfs like this as Alen suggested. But again I am not 
> very sure if this can be done properly without any races. But anyway I am 
> trying.
>                                                                                 
> 1) backout my patch sysfs-pin-kobject.patch

I think we need to do this now, as it is not a correct fix, and causes
more problems than good at this time.  I suggest you try to fix the oops
you were seeing in either another way, or in a way that does not break
other things :)

I'll send a patch off to Linus to do this in a little bit...

thanks,

greg k-h
