Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbTDWRYx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTDWRYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:24:52 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:54429 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264126AbTDWRYv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:24:51 -0400
Date: Wed, 23 Apr 2003 10:39:03 -0700
From: Greg KH <greg@kroah.com>
To: David van Hoose <davidvh@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.21-rc1] USB Trackball broken
Message-ID: <20030423173903.GA11725@kroah.com>
References: <3EA6C558.5040004@cox.net> <20030423172135.GA11572@kroah.com> <3EA6CDB0.8050905@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA6CDB0.8050905@cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 12:30:24PM -0500, David van Hoose wrote:
> Greg KH wrote:
> >On Wed, Apr 23, 2003 at 11:54:48AM -0500, David van Hoose wrote:
> >
> >>I am running RedHat 9. Trackball is detected and works when using the 
> >>stock 2.4.20-9 kernel that RedHat provided.
> >>
> >>With 2.4.21-rc1, I have included the USB and input devices in the 
> >>kernel, as modules, and as various combinations in between. My USB 
> >>Logitech Trackball shows up as being detected and setup, but it doesn't 
> >>work. Attached is my config and a trimmed down dmesg. (ppa is messed up 
> >>and floods me with messages)
> >>I have USB vebose debugging turned on. That may help. Please let me know 
> >>what information you might need in addition.
> >
> >
> >Is this trackball plugged into a USB 2.0 hub or controller?
> >
> >If you cat /dev/input/mice and move the trackball around, do you get
> >data?
> 
> Under the RedHat kernel, I get data.
> Under the 2.4.21-rc1 kernel, I get nothing.

Again, is this device plugged into a hub?  Or directly into the
controller's root hub?  It looks like the device keeps getting
disconnected and reconnected, based on the kernel log you posted.

thanks,

greg k-h
