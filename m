Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbTLXBIL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 20:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbTLXBIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 20:08:11 -0500
Received: from mail.kroah.org ([65.200.24.183]:17059 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262795AbTLXBIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 20:08:10 -0500
Date: Tue, 23 Dec 2003 17:07:28 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Mark Mielke <mark@mark.mielke.cc>, Ian Kent <raven@themaw.net>,
       release@gentoo.org
Subject: Re: DevFS vs. udev
Message-ID: <20031224010728.GA20956@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <E1AYl4w-0007A5-R3@O.Q.NET> <Pine.LNX.4.44.0312240005180.4342-100000@raven.themaw.net> <20031223173429.GA9032@mark.mielke.cc> <20031223220209.GB15946@kroah.com> <1072226715.6917.50.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072226715.6917.50.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 24, 2003 at 02:45:15AM +0200, Martin Schlemmer wrote:
> Lastly, a small nit with udev currently - how long will it be for in
> kernel changes to be in place so that we do not need the 1sec delay?
> It really sucks when you use a script/whatever to populate /dev, and
> reboot quite frequent for new kernel/rc-script testing :)

It's not a kernel change needed, it's a udev/libsysfs change needed.  If
I didn't have to deal with devfs emails I would get a chance to work on
the issue some more :)

And yes, I have gotten tired of the boot issue too, just add a '&' after
the udev call in your init scripts and then everything seems to work
just fine (as far as speed of boot goes.)

And sorry for the Gentoo comment, it wasn't aimed at the developers at
all.  You have helped out a bunch with udev development, and I
appreciate it.  I also appreciate the chore you are undertaking in
moving away from devfs, that's a great step.

But you do have to admit, Gentoo seems to have some pretty rabid users :)

thanks,

greg k-h
