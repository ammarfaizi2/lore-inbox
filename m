Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbUBXXVo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 18:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbUBXXVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 18:21:44 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:15553 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S262528AbUBXXVk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 18:21:40 -0500
Date: Tue, 24 Feb 2004 16:21:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Split kgdb into "lite" and "normal" parts
Message-ID: <20040224232137.GJ1052@smtp.west.cox.net>
References: <20040218225010.GH321@elf.ucw.cz> <200402191322.52499.amitkale@emsyssoft.com> <20040224213908.GD1052@smtp.west.cox.net> <20040224221541.GA9145@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040224221541.GA9145@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 11:15:41PM +0100, Pavel Machek wrote:

> Hi!
> 
> > > Tested (core-lite.patch + i386-lite.patch + 8250.patch) combination.
> > > Looks good.
> > > 
> > > Let's first check this in and then do more cleanups.
> > > Tom, does it sound ok?
> > 
> > This sounds fine to me.  Pavel, I'm guessing you did this with quilt,
> > could you provide some pointers on how to replicate this in the future?
> 
> Unfortunately, I done it by hand :-(. But if -lite parts are not
> merged, soon, I'll be forced to start using quilt. Doing stuff by hand
> is quite painfull...

There's still a whole bunch of bogons in the -lite patch still, so I
don't think it should be merged yet.

-- 
Tom Rini
http://gate.crashing.org/~trini/
