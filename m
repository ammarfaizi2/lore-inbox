Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbTK0PbN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 10:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbTK0PbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 10:31:12 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:4068 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S264540AbTK0PbI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 10:31:08 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Daniel Drake <dan@reactivated.net>
Subject: Re: exiting X and rebooting
Date: Thu, 27 Nov 2003 10:31:06 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200311270617.03654.gene.heskett@verizon.net> <3FC5F8A7.1000709@reactivated.net>
In-Reply-To: <3FC5F8A7.1000709@reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311271031.06390.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.54.127] at Thu, 27 Nov 2003 09:31:07 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 November 2003 08:14, Daniel Drake wrote:
>Which display driver are you using for X? 

XFree's nv from 4.2.1. Card is a GForce2 MX-200.  Sorry, I should have 
included that info.

>Using
> Xinerama/multi-displays or similar? 

No, just an elderly NEC 5FG that refuses to die of old age.

>I noticed this behaviour once
> on a dual-monitor setup. After starting X then exiting it, I
> noticed the problems that you describe on the primary monitor.
> However the secondary monitor was showing the output as normal
> (including cursor) if I remember correctly.
>Both displays were running from a single GeForce4 Ti card, using the
> nvidia binary driver under X. No framebuffer.
>
>Never found the problem, but never really investigated either.
>
>Gene Heskett wrote:
>> Greetings;
>>
>> I'm not sure what category this minor complaint falls under, but
>> since its evidenced by a 2.6 kernel and not a 2.4, this seems like
>> the place.
>>
>> One of the things I've been meaning to mention is that if I'm
>> running a 2.6 kernel, and exit X to reboot, the shell that had a
>> cursor when I started X from it, no longer has a cursor when x has
>> been stopped. This occurs only for 2.6 kernels, but works as usual
>> for 2.4 kernels giving a big full character block for a cursor.
>>
>> One can still type, and the keystrokes are echo'd properly.  But
>> it is a bit un-nerving at first.  Logging clear out and back in
>> again to re-init the shell doesn't help.  The cursor is gone.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

