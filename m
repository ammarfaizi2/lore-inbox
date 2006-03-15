Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWCODjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWCODjB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 22:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWCODjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 22:39:01 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:20428 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964802AbWCODjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 22:39:00 -0500
Date: Tue, 14 Mar 2006 19:38:51 -0800
From: Ryan Phillips <rphillips@gentoo.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Pavlik Vojtech <vojtech@suse.cz>, Ryan Phillips <rphillips@gentoo.org>,
       Duncan <1i5t5.duncan@cox.net>, Meelis Roos <mroos@linux.ee>
Subject: Re: 2.6.16-rc6: all psmouse regressions fixed?
Message-ID: <20060315033851.GA7459@trolocsis.dyndns.org>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org> <20060313190714.GD13973@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
In-Reply-To: <20060313190714.GD13973@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> said:
> On Sat, Mar 11, 2006 at 03:58:12PM -0800, Linus Torvalds wrote:
> >...
> > Dmitry Torokhov:
> >       Input: psmouse - disable autoresync
> >...
> 
> We had the three psmouse regressions below in 2.6.16-rc5.
> 
> Duncan already stated that this patch fixed (more exactly: works around) 
> his problems.
> 
> Does anyone still observe a psmouse regression in 2.6.16-rc6 compared 
> to 2.6.15, or is everything fine now?
> 
> 
> Subject    : usb_submit_urb(ctrl) failed on 2.6.16-rc4-git10 kernel
> References : http://bugzilla.kernel.org/show_bug.cgi?id=6134
> Submitter  : Ryan Phillips <rphillips@gentoo.org>
> Handled-By : Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Status     : workaround: psmouse.resync_time=0

I removed the psmouse.* directive from the rc6 kernel and the keyboard
and mouse are working fine.

-Ryan
