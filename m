Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267569AbTAHOQQ>; Wed, 8 Jan 2003 09:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267815AbTAHOQQ>; Wed, 8 Jan 2003 09:16:16 -0500
Received: from smtp03.web.de ([217.72.192.158]:12293 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S267569AbTAHOQP>;
	Wed, 8 Jan 2003 09:16:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Schlichter <thomas.schlichter@web.de>
To: rct@gherkin.frus.com (Bob_Tracy(0000)), linux-kernel@vger.kernel.org
Subject: Re: XFree86 vs. 2.5.54 - reboot
Date: Wed, 8 Jan 2003 15:24:46 +0100
User-Agent: KMail/1.4.3
References: <20030108140525.DF0434EE7@gherkin.frus.com>
In-Reply-To: <20030108140525.DF0434EE7@gherkin.frus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301081524.46868.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got the same probelm with my K6-III 450, too...
The last version I tested was 2.5.52 and it worked perfektly...
But now with 2.5.54 (I did not test 2.5.53) when the 'nvidia' module is used 
(loading it works with no problems...) the Computer reboots...
If I do not use this module X works...

There seems to be a problem with an other module, too...
'nfsd' is ok to load, but when a remote machine tries to mount a directory a 
reboot occures, too...

I do not know if there is a problem with other modules, if I will find any I 
will report them here...

  Thomas Schlichter


Am Mittwoch, 8. Januar 2003 15:05 schrieb Bob_Tracy(0000:
> This probably applies to immediately prior kernels in the 2.5 series
> as well.  2.5.54 seemed like a good time to jump in and test the waters,
> so to speak...
>
> AMD K6-III 450 running a 2.4.19 kernel with vesafb, XFree86 4.1.0, and
> a USB mouse works fine.  Same setup with a 2.5.54 kernel does a cold
> reboot when I type "startx".  In both cases, the initial video state
> is "vga=791" as set in /etc/lilo.conf.  As far as the crash, there's
> no debug output of any kind in the logs to help narrow down the cause.
>
> As best I can remember, the last time I had everything kinda working
> with a 2.5.X kernel was prior to the introduction of the new module-init
> tools.  This isn't a jab at Rusty et. al.  I'm merely trying to come up
> with an approximate timeframe during which something changed which is
> causing the problem.  The recent framebuffer driver changes probably
> have something to with this issue.
>
> If this is a known problem, would someone be kind enough to summarize
> the discussion or let me know approximately when the discussion took
> place so I can dig for it in the linux-kernel archives?  Thanks!

