Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263239AbVBDFzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbVBDFzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 00:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVBDFzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 00:55:17 -0500
Received: from mta11.adelphia.net ([68.168.78.205]:30141 "EHLO
	mta11.adelphia.net") by vger.kernel.org with ESMTP id S263338AbVBDFzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 00:55:09 -0500
Message-ID: <42030E06.8080900@nodivisions.com>
Date: Fri, 04 Feb 2005 00:54:14 -0500
From: Anthony DiSante <theant@nodivisions.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Has anyone dumped udev for devfs?
References: <42019E0E.1020205@stinkfoot.org> <20050203070415.GC17460@waste.org> <4202F725.8040509@stinkfoot.org> <20050204050822.GT2493@waste.org>
In-Reply-To: <20050204050822.GT2493@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Fries wrote:
 > Any ETA on when udev is going to be ready for prime time?  And, any
 > clue why Fedora insists on relying on a program that does not f*(&%ing
 > work!!!!
 >
 > I am trying to get a Microtek X12 USL scanner attached, and udev fails
 > to mount it, every time.  Has anyone tried uninstalling udev and
 > reinstalling devfs to stop all these damn usb failures?
 >
 > If so, any hints on how not to make your system unstable?
 >
 > TIA
 > Kevin Fries

I haven't gone back to devfs, but I feel your pain.  udev+hal worked fine 
for a couple months, until hald started intermittently locking up.  Now I 
can't go 2 days without a reboot, because hald so often goes into 
"uninterruptible sleep" and is totally unkillable.  I've upgraded udev, hal, 
and my kernel a bunch of times, but nothing has fixed this.  And it's not a 
single piece of hardware; sometimes it's USB, sometimes Firewire, sometimes 
a CDROM, that causes hald to take a nap, permanently.

-Anthony DiSante
http://nodivisions.com/
