Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266060AbUALGVT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 01:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266063AbUALGVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 01:21:19 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:58865 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S266060AbUALGVR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 01:21:17 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
Date: Mon, 12 Jan 2004 01:21:12 -0500
User-Agent: KMail/1.5.1
Cc: torvalds@osdl.org, thomas@winischhofer.net, linux-kernel@vger.kernel.org,
       jsimmons@infradead.org
References: <20040109014003.3d925e54.akpm@osdl.org> <200401112353.43282.gene.heskett@verizon.net> <20040111214259.568cff35.akpm@osdl.org>
In-Reply-To: <20040111214259.568cff35.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401120121.12122.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.56.190] at Mon, 12 Jan 2004 00:21:15 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 January 2004 00:42, Andrew Morton wrote:
>Gene Heskett <gene.heskett@verizon.net> wrote:
>> However, since I've been running 2.6.1-mm1 here, using the rivafb
>> with an elderly gforce2-mx2 32 megger, I've noted that when
>> running kde-3.1.1a with 8 windows, and a couple of them have
>> multimegabyte backdrops, the biggest one being that famous deep
>> space shot from hubble of about 4 or 5 months back.  In any other
>> kernel, switching to that window took about 12 seconds for the
>> backdrop to be converted to 1600x1200x32 and drawn the first time
>> and about 8 seconds for the next time.  But with this 2.6.1-mm1
>> kernel, that repeat window switch is so close to instant that I
>> cannot see it being drawn.
>>
>>  So as far as I'm concerned, this particular set of fb patches to
>>  rivafb *need* to stay in mainline.  I'd sure appreciate it, a
>> bunch.
>
>There are no significant fbdev patches in 2.6.1-mm1.  There is a DRM
>update.

Whatever it is, its pure speed on this system here, Andrew.  DRM? 
lemme see if thats even turned on.  Nope "# CONFIG_DRM is not set"
Doing a make xconfig, I see that if I turn it on, there is not a 
driver for my gforce2/nvidia, so I naturally turned it back off.

I do have VIA and agpgart enabled just above it, and over in the 
framebuffer menu, support for framebuffer and nvidia/riva are both 
checked.

Anyway, something has made a huge difference in window switching 
speeds here, someplace between 2.6.0-mm2 and 2.6.1-mm1.  I like it.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

