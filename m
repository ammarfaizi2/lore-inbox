Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWIFOce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWIFOce (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWIFOce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:32:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28431 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751185AbWIFOcd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:32:33 -0400
Date: Wed, 6 Sep 2006 05:36:38 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [linux-usb-devel] [RFC] USB device persistence across suspend-to-disk
Message-ID: <20060906053637.GI7043@ucw.cz>
References: <20060905091318.42c273d2.rdunlap@xenotime.net> <Pine.LNX.4.44L0.0609051252240.5763-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609051252240.5763-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +main kernel instead of as a separate module, you can put
> > > +"usbcore.persist=1" on the boot command line.  You can also change the
> > > +kernel's behavior on the fly using sysfs: Type
> > > +
> > > +	echo y >/sys/module/usbcore/parameters/persist
> > 
> > Does sysfs treat 'y' as '1'?
> > Anyway, it would be Good to be consistent.
> 
> Yes; I'll change everything to 'y'.

Actually I'd prefer 0/1... that's what other parts of kernel use IIRC.

Otherwise it looks good to me.
						Pavel
-- 
Thanks for all the (sleeping) penguins.
