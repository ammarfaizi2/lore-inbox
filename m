Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264199AbUD0RPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264199AbUD0RPm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 13:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264205AbUD0RPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 13:15:42 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:40497 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S264199AbUD0RPl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 13:15:41 -0400
Date: Tue, 27 Apr 2004 19:17:37 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Marco Cavallini <arm.linux@koansoftware.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem with CONFIG_USB_SL811HS
Message-ID: <20040427171737.GB2465@mars.ravnborg.org>
Mail-Followup-To: Marco Cavallini <arm.linux@koansoftware.com>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <005c01c42b82$60d82f60$0200a8c0@arrakis> <20040426185612.GB28530@kroah.com> <003501c42c24$06e87940$0200a8c0@arrakis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003501c42c24$06e87940$0200a8c0@arrakis>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 08:51:09AM +0200, Marco Cavallini wrote:
> > > I am facing to a problem using linux-2.4.25-vrs2 and/or 2.4.26-vrs1 (ARM
> > > porting).
> > > I think this problem come from the linux kernel and not from ARM patch.
> > > Seems that there is a problem building SL811 USB hosts because if I
> enable
> > > CONFIG_USB_SL811HS option
> > > the driver seems to be not build and is not running.
> >
> > What is the build errors you get when trying to build this driver?
> >
> 
> There is no file.o in drivers/usb/host
> and there is no SL811 host in the kernel,
> the hc_sl811 is not build although I enable CONFIG_USB_SL811HS option.

Did you enable this option using menuconfig?
Please grep for this option in your .config. If it is listed here,
and hc_sl811 is not built then there is a bug in the build system.
But this is so basic so the eror is probarly somewhere else.

	Sam
