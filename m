Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161292AbWGNUpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161292AbWGNUpB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 16:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWGNUpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 16:45:01 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58376 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1161292AbWGNUpA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 16:45:00 -0400
Date: Fri, 14 Jul 2006 20:44:46 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: annoying frequent overcurrent messages.
Message-ID: <20060714204445.GC8731@ucw.cz>
References: <200607132350.55978.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607132350.55978.a1426z@gawab.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-07-06 23:50:55, Al Boldi wrote:
> On Thu, 2006-07-13 at 14:08 +0200, Pavel Machek wrote:
> > > > I have a box that's having its dmesg flooded with..
> > > > 
> > > > hub 1-0:1.0: over-current change on port 1
> > > > hub 1-0:1.0: over-current change on port 2
> > > > hub 1-0:1.0: over-current change on port 1
> > > > hub 1-0:1.0: over-current change on port 2
> > > ...
> > > 
> > > > over and over again..
> > > > The thing is, this box doesn't even have any USB devices connected to 
> > > > it, so there's absolutely nothing I can do to remedy this.
> > > 
> > > Well, overcurrent is a potentially dangerous situation.  That's why it 
> > > gets reported with dev_err priority.
> > 
> > Well, I see overcurrents all the time while doing suspend/resume...
> > 
> > Why is it dangerous? USB should survive plugging something that
> > connects +5V and ground. It may turn your machine off, but that should
> > be it...?
> 
> I don't want to sound alarming here, but I just had a USBFlashStick fried by 
> a machine, while in suspend-to-ram running 2.6.17.

Well, I have one usb sticdk fried by regular use under linux (like --
5 minutes of regular use!) and another fried by my dad on windows. So
these beasts are crap.

> I am blaming hw, but does anybody know how I can get my data back?

Probably not easily. Specialized shop might desolder flash chip and
read it directly... or you may try swapping flash chip into
'not-yet-fried' stick...

-- 
Thanks for all the (sleeping) penguins.
