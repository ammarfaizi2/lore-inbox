Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268130AbTB1UgK>; Fri, 28 Feb 2003 15:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268140AbTB1UgK>; Fri, 28 Feb 2003 15:36:10 -0500
Received: from air-2.osdl.org ([65.172.181.6]:24198 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268130AbTB1UgJ>;
	Fri, 28 Feb 2003 15:36:09 -0500
Date: Fri, 28 Feb 2003 12:41:47 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Kendall Bennett" <KendallB@scitechsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.5 input layer info?
Message-Id: <20030228124147.3756c3cc.rddunlap@osdl.org>
In-Reply-To: <3E5F50EA.13587.3FA4953@localhost>
References: <1786144585.20030228074127@wlink.com.np>
	<3E5F50EA.13587.3FA4953@localhost>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2003 12:07:06 -0800
"Kendall Bennett" <KendallB@scitechsoft.com> wrote:

| I have heard about the new 2.5 input layer work that is being done in the 
| kernel, and I am interested in using this for a userland mouse/keyboard 
| daemon I am looking at building. The intention of the daemon is to 
| provide a common interface for event driven mouse and keyboard 
| applications (ie: XFree86, Qt/E, SDL, MGL, SVGALib etc) on Linux. Since 
| it appears that a lot of work is already being done on a new set of event 
| driven input layers in the kernel, what I would like to do is build this 
| daemon such that it will use the new 2.5 kernel interfaces when they are 
| available, but fall back on the old compatible methods when not. 
| Essentially I am planning on taking the existing XFree86 code and using 
| it to make a common user land input daemon.
| 
| Anyway, let me know if you think this is a good idea, bad idea or if 
| there is a better way to do it. The new input interfaces sound like a 
| great idea, but we are looking for something that will work on as many 
| versions of Linux as possible.
| 
| Finally where can I find more information on the new input interfaces in 
| the 2.5 kernel? I just downloaded the latest 2.5.63 release and will take 
| a look at it, but if there are any external docs on this I would like to 
| peruse them first.

linux/Documentation/input/*
linux/drivers/input/*
Linux Console project: http://linuxconsole.sourceforge.net/
Linux Input drivers:   http://www.suse.cz/development/input/ (not recent)
http://www.codemonkey.org.uk/post-halloween-2.5.txt
Possibly these:
http://www.frogmouth.net/hid-doco/examples/hiddev-misc/write-events.c
http://www.frogmouth.net/hid-doco/examples/hiddev-misc/dump-events.c

HTH.
--
~Randy
