Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbULQTJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbULQTJN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 14:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbULQTJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 14:09:13 -0500
Received: from gprs215-176.eurotel.cz ([160.218.215.176]:4493 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262119AbULQTJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 14:09:10 -0500
Date: Fri, 17 Dec 2004 20:08:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: debugfs in the namespace
Message-ID: <20041217190856.GA29131@elf.ucw.cz>
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan> <20041216190835.GE5654@kroah.com> <20041216113357.4c2714bb@lembas.zaitcev.lan> <20041216194224.GA6640@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216194224.GA6640@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > better, but mounting anything under /proc requires a kernel component
> > to create a directory, does it not?
> 
> Yes it does, but debugfs could create the mount point, if people agree
> that this is a good place to put it (like usbfs does.)
> 
> Personally, I don't want to put it there, but that's just because I hate
> proc stuff :)
> 
> So, /debug sounds good to me.  Any objections?

Yes... /debug is something users may actually use already... Like
having scratch filesystem mount on /debug.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
