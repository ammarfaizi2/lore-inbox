Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266094AbTLISd1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbTLISd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:33:26 -0500
Received: from mail.kroah.org ([65.200.24.183]:17844 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266094AbTLISdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:33:25 -0500
Date: Tue, 9 Dec 2003 10:30:01 -0800
From: Greg KH <greg@kroah.com>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
       Witukind <witukind@nsbm.kicks-ass.org>, recbo@nishanet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Message-ID: <20031209183001.GA9496@kroah.com>
References: <1070963757.869.86.camel@nomade> <Pine.LNX.4.44.0312091358210.21314-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312091358210.21314-100000@gaia.cela.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 02:03:42PM +0100, Maciej Zenczykowski wrote:
> > > > Am I wrong ?
> 
> > > No, you are correct.  That's why I'm not really worried about this, and
> > > I don't think anyone else should be either.
> 
> You are of course totally wrong

Oh, ok.  I'll just go back to writing code instead of arguing...

> - just because a device is present in the system doesn't mean that
> it's kernel modules are loaded

No, but one could argue that it should :)

> - for example my floppy is always present in the system, but I access
> it like once a month or so

Then, when you want to access it, a simple 'modprobe floppy' would work
for you, right?

Anyway, I'm not going to drag this thread out anymore.  If you want to
use devfs, do it.  Just realize that it is an obsolete kernel feature
and is marked for probable removal in 2.7.  It also has known bad
problems that could cause your machine to lock up.  Use it at your own
risk, you have been warned...

greg k-h
