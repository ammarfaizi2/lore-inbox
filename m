Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265621AbUBBFVr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 00:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265629AbUBBFVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 00:21:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:18912 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265621AbUBBFVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 00:21:45 -0500
Date: Sun, 1 Feb 2004 21:13:02 -0800
From: Greg KH <greg@kroah.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotplug question
Message-ID: <20040202051302.GA21549@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <200402012359.46020.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402012359.46020.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 11:59:45PM -0500, Gene Heskett wrote:
> Greetings;
> 
> About a week ago I did and rm -fR on the hotplug stuffs because it was 
> totally hanging the boot for some reason.
> 
> Tonight I re-installed it and did a test reboot to 2.6.2-rc3.  When it 
> got to "Starting hotplug", the init script sat there for around 30 
> seconds, and eventually said OK.  It did load the one module I have 
> set as a module, for the pl-2303 seriel to usb adaptor.  Or at least 
> I didn't have to do it by hand with modprobe.
> 
> Is this huge, even worse than kudzu, boot delay normal for hotplug?

Try enabling the debug messages in the hotplug system to see what is
taking so long.

Yeah, I've seen it take quite some time on some hardware before, as the
different drivers would pause the system as they were loaded.

greg k-h
