Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279864AbRJ3EkK>; Mon, 29 Oct 2001 23:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279865AbRJ3EkA>; Mon, 29 Oct 2001 23:40:00 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:62216 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S279864AbRJ3Ejo>;
	Mon, 29 Oct 2001 23:39:44 -0500
Date: Mon, 29 Oct 2001 20:38:42 -0800
From: Greg KH <greg@kroah.com>
To: Josh Hansen <joshhansen@byu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ease of hardware configuration
Message-ID: <20011029203842.A17967@kroah.com>
In-Reply-To: <01KA2VPVO4QI9JEBL9@EMAIL1.BYU.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01KA2VPVO4QI9JEBL9@EMAIL1.BYU.EDU>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 05:27:34PM -0600, Josh Hansen wrote:
> 	Now here comes the radical part (ok, so all of this is somewhat radical): the 
> configuration utility connects to a server such as linuxdevicedrivers.org or 
> some other slick domain name and downloads the appropriate kernel module 
> binaries for the hardware based on kernel version number and architecture 
> (example: nVidia GeForce module for kernel 2.4.13 on i386, or USB Scanner 
> module for kernel 2.4.4 on PowerPC). Once the module is obtained, it is 
> loaded into the kernel (with explicit IO/IRQ parameters for older hardware if 
> necessary).
> 	Once the module is loaded, the utility quits.

Please check out the linux-hotplug package:
	http://linux-hotplug.sf.net/

It does most of what you are talking about right now.  And if it's
missing anything that you want, feel free to contribute :) 

thanks,

greg k-h
