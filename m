Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVCIS7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVCIS7V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVCIS7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:59:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:17610 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262111AbVCIS7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:59:16 -0500
Date: Wed, 9 Mar 2005 10:58:00 -0800
From: Greg KH <greg@kroah.com>
To: Wen Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ patch 4/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050309185800.GA27268@kroah.com>
References: <20050228063954.GB23595@kroah.com> <4228CE41.2000102@us.ltcfwd.linux.ibm.com> <20050304220116.GA1201@kroah.com> <422CD9DB.10103@us.ltcfwd.linux.ibm.com> <20050308064424.GF17022@kroah.com> <422DF525.8030606@us.ltcfwd.linux.ibm.com> <20050308235807.GA11807@kroah.com> <422F1A8A.4000106@us.ltcfwd.linux.ibm.com> <20050309163518.GC25079@kroah.com> <422F2FDD.4050908@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422F2FDD.4050908@us.ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 12:18:21PM -0500, Wen Xiong wrote:
> Greg KH wrote:
> 
> >On Wed, Mar 09, 2005 at 10:47:22AM -0500, Wen Xiong wrote:
> > 
> >
> >>+static ssize_t jsm_driver_debug_show(struct device_driver *ddp, char 
> >>*buf)
> >>+{
> >>+	return snprintf(buf, PAGE_SIZE, "0x%x\n", jsm_debug);
> >>+}
> >>+static DRIVER_ATTR(debug, S_IRUSR, jsm_driver_debug_show, NULL);
> >>   
> >>
> >
> >Should just be a module paramater, right?  So you can drop this too...
> >
> >This file is getting quite small now :)
> >
> If I removed two module paramaters, only two files left: version and state.
> Removed all of them?

Move them to a different file?

thanks,

greg k-h
