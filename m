Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWIMUyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWIMUyP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 16:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWIMUyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 16:54:15 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:59920 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751191AbWIMUyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 16:54:15 -0400
Date: Wed, 13 Sep 2006 16:54:13 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Mattia Dongili <malattia@linux.it>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
In-Reply-To: <20060913203806.GA5580@inferi.kami.home>
Message-ID: <Pine.LNX.4.44L0.0609131652290.5758-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006, Mattia Dongili wrote:

> > The patch below will add some extra debugging information.  We need to
> > find out why the resume didn't succeed.  Oh -- and of course, you should
> > reinstate all those autosuspend patches.  Otherwise this patch won't 
> > apply!
> 
> ok, with USB_DEBUG=y and this is with your first patch still applied
> http://oioio.altervista.org/linux/dmesg-2.6.18-rc6-mm1-verbose-usb-try2
> 
> this is without it:
> http://oioio.altervista.org/linux/dmesg-2.6.18-rc6-mm1-verbose-usb-try3
> 
> I hope I'm not mixing thing too much with Rafael :)

No.  But this log doesn't include the debugging output in the patch from 
my previous message.

Alan Stern

