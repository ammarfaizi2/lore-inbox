Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310531AbSCGUww>; Thu, 7 Mar 2002 15:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310537AbSCGUwc>; Thu, 7 Mar 2002 15:52:32 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:40971 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S310531AbSCGUv0>;
	Thu, 7 Mar 2002 15:51:26 -0500
Date: Thu, 7 Mar 2002 20:31:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Shaun Jackman <sjackman@shaw.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp: Unable to find swap-space signature
Message-ID: <20020307193126.GA331@elf.ucw.cz>
In-Reply-To: <E16gLkD-0000KR-00@quince.jackman> <20020228094035.GB4760@atrey.karlin.mff.cuni.cz> <E16hfU9-00009r-00@quince.jackman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16hfU9-00009r-00@quince.jackman>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I think I'm making progress.
> I have 128 MB RAM, and a single 256 MB swap partition.
> I pressed SysRq-D, swsusp displayed all sorts of successful messages, and 
> then rebooted my computer. (can I get it to poweroff my computer instead of 
> reboot it?)
> 
> When it started up again, the kernel displayed the message "Unable to find 
> swap-space signature" and went on to fsck. The swap partition seemed dead. I 
> ran mkswap and swapon to get my swap partition back.
> 
> Any idea what went wrong? I'd love to get swsusp working.

Yep, you need to pass resume=/dev/hda3 to resume (on kernel command
line).

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
