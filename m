Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267377AbTACEgU>; Thu, 2 Jan 2003 23:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267379AbTACEgU>; Thu, 2 Jan 2003 23:36:20 -0500
Received: from granite.he.net ([216.218.226.66]:60942 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id <S267377AbTACEgU>;
	Thu, 2 Jan 2003 23:36:20 -0500
Date: Thu, 2 Jan 2003 20:44:44 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Miles Lane <miles.lane@attbi.com>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       usb devel <linux-usb-devel@lists.sourceforge.net>
Subject: Re: 2.5.54 -- ohci-dbg.c: 358: In function `show_list': `data1' undeclared (first use in this function)
Message-ID: <20030102204444.A2549@kroah.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	David Brownell <david-b@pacbell.net>,
	Miles Lane <miles.lane@attbi.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	usb devel <linux-usb-devel@lists.sourceforge.net>
References: <1041487926.11532.83.camel@bellybutton.attbi.com> <3E145998.6020607@pacbell.net> <3E14DBDD.4080907@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E14DBDD.4080907@pacbell.net>; from david-b@pacbell.net on Thu, Jan 02, 2003 at 04:39:57PM -0800
X-Operating-System: Linux 2.2.20 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 04:39:57PM -0800, David Brownell wrote:
> +#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,32)
> +#	define DRIVERFS_DEBUG_FILES
> +#endif

No, this is wrong, don't put this dependant on a specific kernel 
version that is long gone, that's why I took this portion out.

thanks,

greg k-h
