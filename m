Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267212AbUIODpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267212AbUIODpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 23:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267386AbUIODpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 23:45:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:13533 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267212AbUIODpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 23:45:23 -0400
Date: Tue, 14 Sep 2004 20:44:55 -0700
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@ximian.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915034455.GB30747@kroah.com>
References: <20040904005433.GA18229@kroah.com> <1094353088.2591.19.camel@localhost> <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org> <20040910235409.GA32424@kroah.com> <1094875775.10625.5.camel@lucy> <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org> <20040915000753.GA24125@kroah.com> <1095211167.20763.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095211167.20763.2.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 09:19:27PM -0400, Robert Love wrote:
> On Tue, 2004-09-14 at 17:07 -0700, Greg KH wrote:
> 
> > I don't know, the firmware objects already use "add" for an event.  I
> > didn't put a check in the kobject_uevent() calls to prevent the add and
> > remove, but now it's a lot easier to do so if you think it's necessary.
> 
> I have no problem with this, either, so long as we are not too anal or
> strict about adding new actions.

That's fine.  I'll dump them into a separate header file to make it a
bit easier to find and add new ones to.

> In other words, I like the safety and typo prevention that this gives
> us, but want to keep things flexible and easy.

Heh, you want it all, don't you :)

greg k-h
