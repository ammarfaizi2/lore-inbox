Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTDXAdb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbTDXAdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:33:31 -0400
Received: from mail.ccur.com ([208.248.32.212]:12036 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S264374AbTDXAda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:33:30 -0400
Date: Wed, 23 Apr 2003 20:45:34 -0400
From: Joe Korty <joe.korty@ccur.com>
To: David van Hoose <davidvh@cox.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.21-rc1] USB Trackball broken
Message-ID: <20030424004534.GA11258@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <3EA6C558.5040004@cox.net> <20030423172135.GA11572@kroah.com> <3EA6CDB0.8050905@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA6CDB0.8050905@cox.net>
User-Agent: Mutt/1.4i
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

Hi David,
 Having experienced this little nasty myself, I would guess you don't
have CONFIG_USB_HIDINPUT set.

Joe
