Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbTK0PZN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 10:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbTK0PZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 10:25:12 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:226 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S264537AbTK0PZD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 10:25:03 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: exiting X and rebooting
Date: Thu, 27 Nov 2003 10:25:00 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200311270617.03654.gene.heskett@verizon.net> <20031127121656.GA8606@hh.idb.hist.no>
In-Reply-To: <20031127121656.GA8606@hh.idb.hist.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311271025.00858.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.54.127] at Thu, 27 Nov 2003 09:25:02 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 November 2003 07:16, Helge Hafting wrote:
>On Thu, Nov 27, 2003 at 06:17:03AM -0500, Gene Heskett wrote:
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
>
>This seems like a framebuffer problem to me, are you using a
> framebuffer, and if so, which one?
>
>Helge Hafting

Good Q Helge, see this big dummies .config snippets:

[root@coyote linux-2.6]# grep FRAME .config
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAME_POINTER=y
[root@coyote linux-2.6]# grep VESA .config
CONFIG_FB_VESA=y

Since the card is an NVIDIA GForce2 MX200, and X is using its own "nv" 
driver, which one should I turn off?

Thanks.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

