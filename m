Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbULUR3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbULUR3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 12:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbULUR3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 12:29:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:30362 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261786AbULUR3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 12:29:00 -0500
Date: Tue, 21 Dec 2004 09:27:46 -0800
From: Greg KH <greg@kroah.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Adrian Bunk <bunk@stusta.de>, Dan Dennedy <dan@dennedy.org>,
       Ben Collins <bcollins@debian.org>,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
Message-ID: <20041221172746.GI1459@kroah.com>
References: <20041220015320.GO21288@stusta.de> <1103508610.3724.69.camel@kino.dennedy.org> <20041220022503.GT21288@stusta.de> <1103510535.1252.18.camel@krustophenia.net> <1103516870.3724.103.camel@kino.dennedy.org> <20041220225324.GY21288@stusta.de> <1103583486.1252.102.camel@krustophenia.net> <20041221171702.GE1459@kroah.com> <1103649633.9220.12.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103649633.9220.12.camel@krustophenia.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 12:20:32PM -0500, Lee Revell wrote:
> On Tue, 2004-12-21 at 09:17 -0800, Greg KH wrote:
> > On Mon, Dec 20, 2004 at 05:58:06PM -0500, Lee Revell wrote:
> > > On Mon, 2004-12-20 at 23:53 +0100, Adrian Bunk wrote:
> > > > The solution is simple:
> > > > The vendor or services provider submits his driver for inclusion into 
> > > > the kernel which is the best solution for everyone.
> > > > 
> > > 
> > > What if the driver is under development and doesn't work yet?
> > 
> > Many drivers have been accepted into the kernel tree before they worked
> > properly :)
> 
> Yeah but I hope you can understand why someone would be hesitant to
> submit a broken driver.  It just makes the author look bad.  I would not
> feel right submitting something that didn't work.

Everyone has their own comfort levels :)

Anyway, a number of drivers have been submitted to the tree that were
never even tested on hardware (written only to specs).  Then, over time
they were properly debugged by people who had access to the hardware
(debugging over email does have long lags, but it works out in the end.)
An example of this was the first usb bluetooth driver.

But we are getting pretty far off-topic here, sorry.

greg k-h
