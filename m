Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261412AbSIWTrr>; Mon, 23 Sep 2002 15:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261414AbSIWTrq>; Mon, 23 Sep 2002 15:47:46 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:26387 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261411AbSIWTrj>;
	Mon, 23 Sep 2002 15:47:39 -0400
Date: Mon, 23 Sep 2002 12:51:54 -0700
From: Greg KH <greg@kroah.com>
To: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] #include <linux/version.h> missing in drivers/usb/host/ohci-hcd.c
Message-ID: <20020923195154.GC18769@kroah.com>
References: <Pine.LNX.4.33.0209212130360.2433-100000@penguin.transmeta.com> <3D8E3D32.2000707@easynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8E3D32.2000707@easynet.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 11:59:14PM +0200, Luc Van Oostenryck wrote:
> Hi,
> 
> compile fails with the following message:
> 
> 	> In file included from ohci-hcd.c:136:
> 	> ohci-dbg.c:318: parse error
> 	> make[3]: *** [ohci-hcd.o] Error 1
> 
> due to a missing #include <linux/version.h>
> 
> Here is a trivial patch for this.

Thanks, I've added it to my tree.

greg k-h
