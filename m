Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261764AbTC1Ad0>; Thu, 27 Mar 2003 19:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261765AbTC1Ad0>; Thu, 27 Mar 2003 19:33:26 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:58377 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261764AbTC1AdZ>;
	Thu, 27 Mar 2003 19:33:25 -0500
Date: Thu, 27 Mar 2003 16:43:34 -0800
From: Greg KH <greg@kroah.com>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, martin.zwickel@technotrend.de
Subject: Re: 2.4.21pre6: usb ports/mouse not detected
Message-ID: <20030328004334.GF3416@kroah.com>
References: <1048800413.2120.2.camel@fortknox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048800413.2120.2.camel@fortknox>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 10:26:53PM +0100, Soeren Sonnenburg wrote:
> > I had the same problem few hours ago.
> > Loading usb-ohci/ehci-hcd as a module fixed it for me ...
> > But it's just a "It Works for Me(tm)" ...
> 
> I experienced exactly the same problems... and also compiling as modules
> fixed it ...

Yes, the usb host controller drivers do not get built in 2.4.21-pre6 if
selected to be compiled into the kernel.  This was my fault, and a patch
has been sent to Marcelo to fix this.

Sorry,

greg k-h
