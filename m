Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266070AbUALG6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 01:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266071AbUALG6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 01:58:12 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:654 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S266070AbUALG6I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 01:58:08 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
Date: Mon, 12 Jan 2004 01:58:03 -0500
User-Agent: KMail/1.5.1
Cc: torvalds@osdl.org, thomas@winischhofer.net, linux-kernel@vger.kernel.org,
       jsimmons@infradead.org
References: <20040109014003.3d925e54.akpm@osdl.org> <200401120121.12122.gene.heskett@verizon.net> <20040111223443.16166e07.akpm@osdl.org>
In-Reply-To: <20040111223443.16166e07.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401120158.03014.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.56.190] at Mon, 12 Jan 2004 00:58:06 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 January 2004 01:34, Andrew Morton wrote:
>Gene Heskett <gene.heskett@verizon.net> wrote:
>> >There are no significant fbdev patches in 2.6.1-mm1.  There is a
>> > DRM
>> >
>>  >update.
>>
>>  Whatever it is, its pure speed on this system here, Andrew.  DRM?
>>  lemme see if thats even turned on.  Nope "# CONFIG_DRM is not
>> set" Doing a make xconfig, I see that if I turn it on, there is
>> not a driver for my gforce2/nvidia, so I naturally turned it back
>> off.
>>
>>  I do have VIA and agpgart enabled just above it, and over in the
>>  framebuffer menu, support for framebuffer and nvidia/riva are
>> both checked.
>>
>>  Anyway, something has made a huge difference in window switching
>>  speeds here, someplace between 2.6.0-mm2 and 2.6.1-mm1.  I like
>> it.
>
>Beats me.  Doing that vmstat measurement which Vladis suggests would
> be interesting.

See my reply to Vladis of 30 seconds ago, it gets even curiouser!
vmstat 1 segfaults, /proc/1/mem isn't readable.
Interesting indeed.  And I cannot get at the stats with ksysguard, 
"cannot connect to FQDN"  I didn't have that enabled in gkrellm, and 
when I do its just a blank header, so its not getting anything 
either.

Yup, curiouser and curiouser...

Whats interesting in /sys in this area?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

