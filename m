Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266129AbUHHSZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbUHHSZz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 14:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUHHSZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 14:25:48 -0400
Received: from gprs214-188.eurotel.cz ([160.218.214.188]:1920 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266137AbUHHSY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 14:24:56 -0400
Date: Sun, 8 Aug 2004 20:24:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: crow@old-fsckful.ath.cx
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.8-rc2-mm2] swsusp results on a hp compaq nx7000
Message-ID: <20040808182440.GB620@elf.ucw.cz>
References: <20040804120303.GA1828@final-judgement.ath.cx> <20040806201107.GD30518@elf.ucw.cz> <20040808092853.GC26305@old-fsckful.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040808092853.GC26305@old-fsckful.ath.cx>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > * locking with regard to preemption seems so be broken

I see it here, too.

> > > * ohci1394 seems to generate sporadic OOPs on resume (could be
> > >   preemption related)

I do not have firewire device to test with... There seem to be very
little of those beasts around, so I propose to ignore firewire for
now.

> > > * radeonfb gives a "radeonfb: resumed" message on suspending. This may
> > >   be correct (if you suspend the driver and resume it afterwards to
> > >   display more on-screen), but it is a rather disturbing message.

It is correct (but also completely useless) message. Feel free to
sumbit a patch to remove it (through radeonfb people).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
