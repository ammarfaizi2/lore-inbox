Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263533AbTKQQfK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 11:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263553AbTKQQfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 11:35:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:59625 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263533AbTKQQfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 11:35:06 -0500
Date: Mon, 17 Nov 2003 08:45:50 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Rob Landley <rob@landley.net>
cc: Pavel Machek <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: Patrick's Test9 suspend code.
In-Reply-To: <200311162038.31091.rob@landley.net>
Message-ID: <Pine.LNX.4.44.0311170844230.12994-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Currently, patrick's code isn't working for me anymore either.  I think it's 
> because I haven't figured out how I had ACPI set up last time (performance 
> covernor, probably.  If I tell it to use the userspace governor, there's 
> still nothing in /sys/devices/system/cpu/cpu0, the directory is empty.  Maybe 
> the documentation isn't up to date anymore, I don't know...)  When I tried to 
> suspend with it, it sort of worked but the writing to disk phase (which never 
> caused a problem before) had a visible pause between each sector written, and 
> writing out the 3000 sectors took over 5 minutes, and the end result wasn't 
> something it could resume from anyway.  Sigh...

Are you using preempt? There was a similar problem reported a while back 
that was solved by disabling it. Though it's not a true fix, it should at 
least get you going again.

Thanks,


	Pat


