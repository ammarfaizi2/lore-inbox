Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422656AbWA0WxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422656AbWA0WxU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422660AbWA0Ww5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:52:57 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:50131
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1422661AbWA0Wwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:52:53 -0500
Date: Fri, 27 Jan 2006 14:52:53 -0800
From: Greg KH <greg@kroah.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Linux 2.6.16-rc1 - usb printer problems
Message-ID: <20060127225253.GA22666@kroah.com>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> <20060127000630.GA13008@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127000630.GA13008@aitel.hist.no>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 01:06:30AM +0100, Helge Hafting wrote:
> There seems to be a usb printer problem in 2.6.16-rc1 (amd64)
> 
> I can print a page or two of graphichs (A4 maps), and then 
> my syslog fills up with these:
> kernel: drivers/usb/class/usblp.c: usblp0: error -19 reading printer status
> 
> It is then time to power-cycle the printer, restart cups and
> maybe get another page out.  Or maybe not. Going back to 2.6.15 I don't
> see such problems, the printer cranks out page after page with ease.
> 
> Known issue, or is some USB debugging in place?

Not a known issue at all.  This works just fine for me here, on i386.
Anyone on linux-usb-devel having problems?

thanks,

greg k-h
