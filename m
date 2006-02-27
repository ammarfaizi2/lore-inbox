Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWB0GjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWB0GjP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 01:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbWB0GjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 01:39:15 -0500
Received: from styx.suse.cz ([82.119.242.94]:34463 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751569AbWB0GjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 01:39:13 -0500
Date: Mon, 27 Feb 2006 07:39:31 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ryan Phillips <ryan@trolocsis.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>,
       Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>,
       Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net,
       Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, Luming Yu <luming.yu@intel.com>,
       len.brown@intel.com, linux-acpi@vger.kernel.org,
       Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>,
       jgarzik@pobox.com, linux-ide@vger.kernel.org,
       Duncan <1i5t5.duncan@cox.net>, linux-input@atrey.karlin.mff.cuni.cz,
       Meelis Roos <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions
Message-ID: <20060227063930.GA8018@suse.cz>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060227061354.GO3674@stusta.de> <44029BA1.8030601@trolocsis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44029BA1.8030601@trolocsis.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 10:26:41PM -0800, Ryan Phillips wrote:
> Adrian Bunk wrote:
> > This email lists some known regressions in 2.6.16-rc5 compared to 2.6.15.
> >
> > If you find your name in the Cc header, you are either submitter of one
> > of the bugs, maintainer of an affectected subsystem or driver, a patch
> > of you was declared guilty for a breakage or I'm considering you in any
> > other way possibly involved with one or more of these issues.
> >
> > Due to the huge amount of recipients, this email has a Reply-To set.
> > Please add the appropriate people to the Cc when replying regarding one 
> > of these issues.
> >
> >
> > Subject    : usb_submit_urb(ctrl) failed on 2.6.16-rc4-git10 kernel
> > References : http://bugzilla.kernel.org/show_bug.cgi?id=6134
> > Submitter  : Ryan Phillips <rphillips@gentoo.org>
> > Status     : unknown
> >
> >   
> *snipped
> > Subject    : total ps2 keyboard lockup from boot
> > References : http://bugzilla.kernel.org/show_bug.cgi?id=6130
> > Submitter  : Duncan <1i5t5.duncan@cox.net>
> > Handled-By : Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >              Pavlik Vojtech <vojtech@suse.cz>
> > Status     : discussion and debugging in the bug logs
> >
> >   
> *snipped
> 
> It appears that Duncan's "total ps2 keyboard lockup from boot" is the
> same, or similar problem as mine.
> 2.6.15.1 kernel is working for me though.
 
Except one of the keyboards is USB and the other PS/2. Both are
Microsoft wireless, though.

-- 
Vojtech Pavlik
Director SuSE Labs
