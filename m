Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbTL0L4l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 06:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbTL0L4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 06:56:41 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:34736 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264329AbTL0L4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 06:56:39 -0500
Date: Sat, 27 Dec 2003 19:57:03 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Jari Soderholm <Jari.Soderholm@edu.stadia.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: DEVFS is very good compared to UDEV
In-Reply-To: <sfe8cdc2.027@mail2.edu.stadia.fi>
Message-ID: <Pine.LNX.4.44.0312271933150.3256-100000@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003, Jari Soderholm wrote:

> 
> Booting kernel is faster compared to UDEV.

Mmm. Doesn't seem that way to me. What have I missed?

> 
> UDEV otherwise is very complex for average user and it
> is definetly much slower , it has much greater chance
> for errors because very complicated scrips which seem 
> to need many different gnu commandline utilities.

Didn't seem to difficult to me when I checked out both systems this last 
few days. In fact I like'em both.

> 
> It is quite funny that when DEVFS creates device files
> automagically and in the ram-memory, some people want
> to go backwards, and use shell scripts to 
> create those files on hard disk, and then it is technically better solution.

Some how I don't think that's the reason for that statement.

> 
> If one you look at the /sysfs-directory there are
> device filenames, (but not the actual devicefiles), so
> it does same thing that DEVFS, but actually much worce
> way, it created devicefilenames in the ram, but
> one cannot use them, because they are not devicefiles.

Looks to me like that was never the aim of sysfs. I haven't checked into 
sysfs yet but I suspect it is quite different to devfs.

> 
> Why could you develop it so that UDEV could create those
> actual device files there also, then most linux
> users would not need those horrible scipts anymore.
> All that is then needed link from /sysfs to /dev dir.

That would take away the ability to have a changeable device naming 
scheme. One of the main reasons for having dynamic device name mapping 
system is to map the names from a device detection system to specified 
(possibly changing) naming scheme.

Please don't get me wrong. I like devfs very much and I see it has come a 
long way since I last used it, but it needs work just to maintain its 
current functionality within 2.6.

Ian


