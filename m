Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267743AbUIXFQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267743AbUIXFQF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 01:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267749AbUIXFQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 01:16:05 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:26347 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S267743AbUIXFQA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 01:16:00 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [patch 03/21] video/radeon_base: replace MS_TO_HZ() with msecs_to_jiffies()
Date: Fri, 24 Sep 2004 01:15:59 -0400
User-Agent: KMail/1.7
Cc: janitor@sternwelten.at, akpm@digeo.com, nacc@us.ibm.com
References: <E1CAaFx-0000wQ-2B@sputnik> <200409240012.47738.gene.heskett@verizon.net> <9e47339104092321383efdd7ee@mail.gmail.com>
In-Reply-To: <9e47339104092321383efdd7ee@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409240115.59202.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.9.92] at Fri, 24 Sep 2004 00:15:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 September 2004 00:38, Jon Smirl wrote:
>That patch didn't fix your performance. It modifies the timer for
> the panel backlight on laptops. Something else fixed your speed
> problem.

Oh dear, now we're back to the phase of the moon theory?  I don't go 
to that church.

I didn't change anything else John.  I had previously rebuilt rc2-mm2 
2 times because I'd found that cachefs wasn't what I thought it was 
and took that back out, leaving me still stuck at 10 fps for either 
instance and I did check.  Applied the subject line patch, 
rebuilt/reboot again without even calling a make xconfig, and I get 
250 fps.  Steady, rather than fading down to the 100 fps in about a 
minute like all previous kernels have in this 2.6.8 and up series.

Several things are locally built here: X, amanda, kde, cups, 
gutenprint, sane, xsane and all kernels.  I don't think yum replaced 
anything but mozilla (up to 1.7.3 now) last night.  Not according to 
the email I got from it anyway.  That, and this patch are the only 
diffs.  I've since did the patch that takes out the #define from the 
radeonfb.h file but I haven't rebooted to that kernel yet.  From my 
read of that file, its just housekeeping, like sweeping the floor.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
