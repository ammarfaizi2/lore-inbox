Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290907AbSAaD6e>; Wed, 30 Jan 2002 22:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290909AbSAaD6Y>; Wed, 30 Jan 2002 22:58:24 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:25351 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290907AbSAaD6N>;
	Wed, 30 Jan 2002 22:58:13 -0500
Date: Wed, 30 Jan 2002 19:56:51 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@suse.de>, Nathan <wfilardo@fuse.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Various issues with 2.5.2-dj6
Message-ID: <20020131035651.GC31006@kroah.com>
In-Reply-To: <3C58B3DD.3000800@fuse.net> <20020131041901.H31313@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020131041901.H31313@suse.de>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 03 Jan 2002 01:45:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 04:19:01AM +0100, Dave Jones wrote:
> On Wed, Jan 30, 2002 at 10:02:53PM -0500, Nathan wrote:
>  
>  > Issue 3: Turning off hotplug (/etc/init.d/hotplug stop on a Debian 
>  > unstable box - updated today) gives the following oopses (captured by 
>  > "klogd -x") - see below.
> 
>  Could be related to the usb-driverfs changes, 2.5.3-dj1 is still cooking
>  here, but has Greg KH's updated version of this work. See if you
>  can repeat it later..

Agreed.  The original usb driverfs patch could be oopsed by removing the
host controller driver.  Hopefully my more recent patch is more stable.
Let me know if you have a problem with that one.

thanks,

greg k-h
