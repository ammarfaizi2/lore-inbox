Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290333AbSCCXZN>; Sun, 3 Mar 2002 18:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290423AbSCCXZF>; Sun, 3 Mar 2002 18:25:05 -0500
Received: from h24-71-223-13.cg.shawcable.net ([24.71.223.13]:9942 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S290333AbSCCXYo>; Sun, 3 Mar 2002 18:24:44 -0500
Date: Sun, 03 Mar 2002 15:33:45 -0800
From: Shaun Jackman <sjackman@shaw.ca>
Subject: swsusp: Unable to find swap-space signature
In-Reply-To: <20020228094035.GB4760@atrey.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Message-id: <E16hfU9-00009r-00@quince.jackman>
MIME-version: 1.0
X-Mailer: KMail [version 1.3.2]
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
In-Reply-To: <E16gLkD-0000KR-00@quince.jackman>
 <20020228094035.GB4760@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I'm making progress.
I have 128 MB RAM, and a single 256 MB swap partition.
I pressed SysRq-D, swsusp displayed all sorts of successful messages, and 
then rebooted my computer. (can I get it to poweroff my computer instead of 
reboot it?)

When it started up again, the kernel displayed the message "Unable to find 
swap-space signature" and went on to fsck. The swap partition seemed dead. I 
ran mkswap and swapon to get my swap partition back.

Any idea what went wrong? I'd love to get swsusp working.

Thanks,
Shaun
