Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266022AbTLIQd6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 11:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266040AbTLIQd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 11:33:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:42635 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266022AbTLIQd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 11:33:57 -0500
Date: Tue, 9 Dec 2003 08:27:47 -0800
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
Message-ID: <20031209162747.GB8675@kroah.com>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <pan.2003.12.08.23.04.07.111640@dungeon.inka.de> <20031208233428.GA31370@kroah.com> <1070953338.7668.6.camel@simulacron> <20031209083228.GC1698@kroah.com> <3FD59CED.6090408@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD59CED.6090408@portrix.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 10:59:09AM +0100, Jan Dittmer wrote:
> Btw. I still haven't figured out, how to use udev properly. I just get
> the nodes of devices I plugin after boot and of the modules I load after
> boot. IDE et all aren't showing up. How early do I need to load udev or
> has my kernel to be all modular for it to work properly?

Like Matthew stated, either use the udev rc startup script, or put udev
into your initramfs image to catch all of the early boot messages.
Doing the initramfs method is still very tough to do right now, but
people have reported success that way.  I still recommend just using the
init.d script for now.

Oh, and if you do have any udev problems, please post them to the
linux-hotplug-devel mailing list.

thanks,

greg k-h
