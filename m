Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbUCaOIH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 09:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUCaOIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 09:08:07 -0500
Received: from xizor.is.scarlet.be ([193.74.71.21]:28895 "EHLO
	xizor.is.scarlet.be") by vger.kernel.org with ESMTP id S261603AbUCaOIE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 09:08:04 -0500
Date: Wed, 31 Mar 2004 16:11:15 +0200
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] speedtouch and/or USB problem (2.6.4-WOLK2.3)
Message-ID: <20040331141115.GA9792@gouv>
References: <Pine.LNX.4.58.0403272228360.2662@alpha.polcom.net> <Pine.LNX.4.44L0.0403271851040.2209-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0403271851040.2209-100000@ida.rowland.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Leopold Gouverneur <gvlp@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2004 at 06:51:36PM -0500, Alan Stern wrote:
> On Sat, 27 Mar 2004, Grzegorz Kulewski wrote:
> 
> > Hi,
> > 
> > When running modem_run on 2.6.4-WOLK2.3 it locks in D state on one of USB 
> > ioctls. It works at least on 2.6.2-rc2. I have no idea what causes this 
> > bug so I sent it to all lists.
> > 
> > Please help if you can.
> > 
> > Grzegorz Kulewski
> 
> Try applying this patch:
> 
> http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108016447231291&q=raw
> 
> Alan Stern
> 
This patch seems to be included in 2.6.5-rc2 bk-curent but it don't
solve the same problem with xsane (or scanimage) which hangs in
ioctl(n, USBDEVFS_SETCONFIGURATION) when accessing my Epson USB Sc
anner.Not the first time I run it but each time after that.
The process remains in D state for many hours before returning for no
evident reason.Was working fine in 2.6.3.
