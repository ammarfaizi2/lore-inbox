Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270653AbTGUTVY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 15:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270669AbTGUTVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 15:21:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5395 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270653AbTGUTVX (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Mon, 21 Jul 2003 15:21:23 -0400
Date: Mon, 21 Jul 2003 21:36:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.redhat.com
Subject: Re: swsusp / 2.6.0-test1
Message-ID: <20030721193615.GB473@elf.ucw.cz>
References: <1058805510.15585.7.camel@simulacron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058805510.15585.7.camel@simulacron>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> swsusp is working fine, but mplayer
> in sdl and xv output mode displays a blank
> screen after a resume. 

What kernel version?

> Piii, debian unstable, dell latitude c600, 
> 01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility M3
> AGP 2x (rev 02)
> CONFIG_DRM=y
> CONFIG_DRM_R128=y
> 
> what else shall I post, or how can I debug the problem?

You probably need to write suspend/resume support for your card.

								Pavel


> 
> other issues:
>  - hostap driver 0.0.3 doesn't work. But pcmcia stop/start
>    fixed it. but that required a kernel patch anyway, as
>    hostap still isn't part of the kernel and thus maybe not
>    up to date (don't know).
>  - there are at least two suspend events, one for pressing
>    and one for releasing the key. I wrote a script that
>    creates a pid file and removed it 30 seconds later -
>    and in the mean time ignored any request to suspend.
>    (if you press the suspend key longer, you get even more events.)
> 
> Regards, Andreas
> 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
