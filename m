Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbUACWSU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 17:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbUACWSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 17:18:20 -0500
Received: from mail.kroah.org ([65.200.24.183]:1423 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264272AbUACWQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 17:16:14 -0500
Date: Sat, 3 Jan 2004 14:16:04 -0800
From: Greg KH <greg@kroah.com>
To: Witukind <witukind@nsbm.kicks-ass.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: udev and devfs - The final word
Message-ID: <20040103221604.GJ11061@kroah.com>
References: <20031231002942.GB2875@kroah.com> <20040101011855.GA13628@hh.idb.hist.no> <20040103055938.GD5306@kroah.com> <20040103140140.3b848e9f.witukind@nsbm.kicks-ass.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040103140140.3b848e9f.witukind@nsbm.kicks-ass.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 02:01:40PM +0100, Witukind wrote:
> On Fri, 2 Jan 2004 21:59:38 -0800
> Greg KH <greg@kroah.com> wrote:
> 
> > On Thu, Jan 01, 2004 at 02:18:55AM +0100, Helge Hafting wrote:
> > > On Tue, Dec 30, 2003 at 04:29:42PM -0800, Greg KH wrote:
> > > > 
> > > >  2) We are (well, were) running out of major and minor numbers for
> > > >     devices.
> > > 
> > > devfs tried to fix this one by _getting rid_ of those numbers.
> > > Seriously - what are they needed for?  
> > 
> > But devfs failed in this.  The devfs kernel interface still requires a
> > major/minor number to create device nodes.
> 
> Let's be more precise and not say that "devfs" failed this, but that the
> current implementation of devfs failed this.

Um, that's all we have to go by right now, sorry.

> If devfs works good on FreeBSD, it probably means that the current
> devfs for Linux is badly designed, not that the idea of devfs is bad.

I have no idea how FreeBSD implemented devfs.

If you know how FreeBSD implemented devfs, and how it solves all of the
problems that I detailed in my original posting, I would be interested.

thanks,

greg k-h
