Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263210AbTJURxR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 13:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263214AbTJURxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 13:53:17 -0400
Received: from mail.kroah.org ([65.200.24.183]:8404 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263210AbTJURxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 13:53:15 -0400
Date: Tue, 21 Oct 2003 10:44:26 -0700
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: clemens@dwf.com, linux-hotplug-devel@lists.sourceforge.net,
       KML <linux-kernel@vger.kernel.org>, reg@orion.dwf.com
Subject: Re: [ANNOUNCE] udev 003 release
Message-ID: <20031021174426.GA1497@kroah.com>
References: <20031017055652.GA7712@kroah.com> <200310171757.h9HHvGiY006997@orion.dwf.com> <20031017181923.GA10649@kroah.com> <20031017182754.GA10714@kroah.com> <1066696767.10221.164.camel@nosferatu.lan> <20031021005025.GA28269@kroah.com> <1066698679.10221.178.camel@nosferatu.lan> <20031021024322.GA29643@kroah.com> <1066707482.10221.243.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066707482.10221.243.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 05:38:02AM +0200, Martin Schlemmer wrote:
> 
> Been in the tree for about a week - removed it though (0.2), so only
> have 003 presently.  I also missed the /etc/hotplug.d/default/ symlink,
> so initial integration needs tweaking.

Do you also have the latest hotplug scripts in gentoo?

> So far have not had any complaints, except for minimal support at this
> stage, but hey, its still early in the game =)

Nice.  Be sure to let me know if you do hear any.

Remember, gentoo needs to wean itself off of devfs for 2.6...

> Also, I am using ramfs for now to do the device nodes, and have not
> looked at minimal /dev layout, although I guess it is not that minimal,
> as even the input drivers lack udev (sysfs) support currently it seems.
> Wat was the last eta for initramfs again ?

initramfs is in the kernel, you use it to boot already :)

thanks,

greg k-h
