Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264120AbTDWRKN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTDWRKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:10:13 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:52947 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264120AbTDWRKK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:10:10 -0400
Date: Wed, 23 Apr 2003 10:21:35 -0700
From: Greg KH <greg@kroah.com>
To: David van Hoose <davidvh@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.21-rc1] USB Trackball broken
Message-ID: <20030423172135.GA11572@kroah.com>
References: <3EA6C558.5040004@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA6C558.5040004@cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 11:54:48AM -0500, David van Hoose wrote:
> I am running RedHat 9. Trackball is detected and works when using the 
> stock 2.4.20-9 kernel that RedHat provided.
> 
> With 2.4.21-rc1, I have included the USB and input devices in the 
> kernel, as modules, and as various combinations in between. My USB 
> Logitech Trackball shows up as being detected and setup, but it doesn't 
> work. Attached is my config and a trimmed down dmesg. (ppa is messed up 
> and floods me with messages)
> I have USB vebose debugging turned on. That may help. Please let me know 
> what information you might need in addition.

Is this trackball plugged into a USB 2.0 hub or controller?

If you cat /dev/input/mice and move the trackball around, do you get
data?

thanks,

greg k-h
