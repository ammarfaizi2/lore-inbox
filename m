Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUALHDh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 02:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266071AbUALHDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 02:03:37 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:53747 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S266069AbUALHDf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 02:03:35 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
Date: Mon, 12 Jan 2004 02:03:30 -0500
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
Message-Id: <200401120203.30207.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.56.190] at Mon, 12 Jan 2004 01:03:34 -0600
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
I just found that the old standby, top, is apparently showing sane 
memory values.
---
Mem:   514720K av,  511360K used,    3360K free,       0K shrd,   
11468K buff
Swap: 3857104K av,   42292K used, 3814812K free                  
317328K cached
---
So at least one program knows howto get at the data.
-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

