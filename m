Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbUACSds (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 13:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUACSds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 13:33:48 -0500
Received: from gprs214-81.eurotel.cz ([160.218.214.81]:60032 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263702AbUACSdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 13:33:47 -0500
Date: Sat, 3 Jan 2004 19:34:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Wrapping jiffies [was Re: udev and devfs - The final word]
Message-ID: <20040103183428.GC1080@elf.ucw.cz>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <20040101001549.GA17401@win.tue.nl> <1072917113.11003.34.camel@fur> <200401010634.28559.rob@landley.net> <1072970573.3975.3.camel@fur> <20040101164831.A2431@pclin040.win.tue.nl> <1072972440.3975.29.camel@fur> <Pine.LNX.4.58.0401021238510.5282@home.osdl.org> <20040103040013.A3100@pclin040.win.tue.nl> <Pine.LNX.4.58.0401022033010.10561@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401022033010.10561@home.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> actively do things that are "silly" on purpose. For example, for 
> debugging, we start the "jiffies" counter not at zero, but at -300. That's 
> patently _silly_, but it was very useful in finding the cases where the 
> rare general case was not handled correctly.

BTW, as we are currently in stable series, it might be good idea to
make jiffies start at zero... Hopefully jiffie wrap had enough testing
during stable...

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
