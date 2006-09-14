Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWINUUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWINUUs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWINUUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:20:48 -0400
Received: from aa001msr.fastwebnet.it ([85.18.95.64]:24233 "EHLO
	aa001msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751128AbWINUUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:20:48 -0400
Date: Thu, 14 Sep 2006 22:19:19 +0200
From: Mattia Dongili <malattia@linux.it>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
Message-ID: <20060914201919.GB3963@inferi.kami.home>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
	Kernel development list <linux-kernel@vger.kernel.org>,
	USB development list <linux-usb-devel@lists.sourceforge.net>
References: <20060913203806.GA5580@inferi.kami.home> <Pine.LNX.4.44L0.0609131652290.5758-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609131652290.5758-100000@iolanthe.rowland.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.18-rc5-mm1-3 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 04:54:13PM -0400, Alan Stern wrote:
> On Wed, 13 Sep 2006, Mattia Dongili wrote:
> 
> > > The patch below will add some extra debugging information.  We need to
> > > find out why the resume didn't succeed.  Oh -- and of course, you should
> > > reinstate all those autosuspend patches.  Otherwise this patch won't 
> > > apply!
> > 
> > ok, with USB_DEBUG=y and this is with your first patch still applied
> > http://oioio.altervista.org/linux/dmesg-2.6.18-rc6-mm1-verbose-usb-try2
> > 
> > this is without it:
> > http://oioio.altervista.org/linux/dmesg-2.6.18-rc6-mm1-verbose-usb-try3
> > 
> > I hope I'm not mixing thing too much with Rafael :)
> 
> No.  But this log doesn't include the debugging output in the patch from 
> my previous message.

doh! I'm pretty sure the patch is applied...
$ patch -p1 --dry-run < ../add_usb_debug.patch
patching file drivers/usb/core/driver.c
Reversed (or previously applied) patch detected!  Assume -R? [n]

Will try again with USB_SUSPEND=y, tomorrow I'll try to find some time
to test all the other things you suggested  (if still necessary) :)
-- 
mattia
:wq!
