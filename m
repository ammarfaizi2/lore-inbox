Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161338AbWHDReF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161338AbWHDReF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 13:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161336AbWHDReE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 13:34:04 -0400
Received: from ns.suse.de ([195.135.220.2]:51680 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161292AbWHDReD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 13:34:03 -0400
Date: Fri, 4 Aug 2006 10:33:49 -0700
From: Greg KH <gregkh@suse.de>
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Problem: irq 217: nobody cared + backtrace
Message-ID: <20060804173349.GB10748@suse.de>
References: <Pine.LNX.4.44L0.0608031158560.7384-100000@iolanthe.rowland.org> <1154705591.5588.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154705591.5588.3.camel@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 04:33:11PM +0100, Sergio Monteiro Basto wrote:
> On Thu, 2006-08-03 at 12:08 -0400, Alan Stern wrote:
> > In case it happens again, here's how 
> > you can get more information.  Turn on CONFIG_USB_DEBUG and 
> > CONFIG_DEBUG_FS, and mount a debugfs filesystem somewhere (say 
> > /sys/kernel/debug).  Then after the problem occurs, save a copy of 
> > 
> >         /sys/kernel/debug/uhci/0000:00:1d.1 
> 
> can you explain to me how I mount debugfs filesystem ? please

as root:
	mount -t debugfs none /sys/kernel/debug

thanks,

greg k-h
