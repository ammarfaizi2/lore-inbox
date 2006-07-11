Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWGKNy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWGKNy6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWGKNy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:54:58 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:7440 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750795AbWGKNy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:54:58 -0400
Date: Tue, 11 Jul 2006 09:54:56 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Roman Zippel <zippel@linux-m68k.org>
cc: Fredrik Roubert <roubert@df.lth.se>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       <linux-input@atrey.karlin.mff.cuni.cz>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Magic Alt-SysRq change in 2.6.18-rc1
In-Reply-To: <Pine.LNX.4.64.0607102356460.17704@scrub.home>
Message-ID: <Pine.LNX.4.44L0.0607110950480.6422-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006, Roman Zippel wrote:

> Hi,
> 
> On Mon, 10 Jul 2006, Fredrik Roubert wrote:
> 
> > > Before 2.6.18-rc1, I used to be able to use it as follows:
> > >
> > > 	Press and hold an Alt key,
> > > 	Press and hold the SysRq key,
> > > 	Release the Alt key,
> > > 	Press and release some hot key like S or T or 7,
> > > 	Repeat the previous step as many times as desired,
> > > 	Release the SysRq key.
> > >
> > > This scheme doesn't work any more,
> > 
> > The SysRq code has been updated to make it useable with keyboards that
> > are broken in other ways than your. With the new behaviour, you should
> > be able to use Magic SysRq with your keyboard in this way:

Thanks to everyone who replied.  Holding down the Alt key instead of the 
SysRq key does indeed make everything work well.

> Apparently it changes existing well documented behaviour, which is a 
> really bad idea.

In this case it's not all that bad, because Alt-SysRq is used only by a 
relatively small community of developers (it is a debugging tool, after 
all).

Changing well documented behavior wouldn't be so bad if the changes were
also well documented and easily available for perusal.  Perhaps there
should be an area on www.kernel.org devoted to listing the new features
and changes added by each kernel release.

Alan Stern

