Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267483AbUJBS3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267483AbUJBS3M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 14:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267487AbUJBS3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 14:29:12 -0400
Received: from gprs214-140.eurotel.cz ([160.218.214.140]:1152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267483AbUJBS3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 14:29:01 -0400
Date: Sat, 2 Oct 2004 20:09:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Howat <tony@i-r-genius.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reading ati_remote keypresses in userland
Message-ID: <20041002180923.GA4290@elf.ucw.cz>
References: <20041002135118.M79981@i-r-genius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041002135118.M79981@i-r-genius.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have an ati_ remote, and the ati_remote module loaded, the 2.2.0 version 
> with kernel version 2.6.5-1. It works in that I can see data 
> on /dev/input/mice when I use the mouse type controls on the remote. However 
> I need to use the keyboardish buttons to control my application. 
> 
> Having read round it seemed the /dev/input/event devices would be the key. I 
> put together some code to find the right event device and dump the output 
> from a linux journal article : 
> 
> The device on /dev/input/event0 says its name is PS/2 Generic Mouse 
> The device on /dev/input/event1 says its name is AT Translated Set 2 
> keyboard 
> The device on /dev/input/event2 says its name is X10 Wireless Technology Inc 
> USB Receiver 
> evdev driver version is 1.0.0 
> 
> ...but there's no output turning up when I read from the file descriptor. 
> However, running the module in debug mode does give meaningful output to 
> /var/log/messages : 

You need to read in slightly special way, see for example evtest.

									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
