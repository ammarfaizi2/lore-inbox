Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUGLUVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUGLUVC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 16:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUGLUVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 16:21:02 -0400
Received: from gprs214-117.eurotel.cz ([160.218.214.117]:1152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262380AbUGLUUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 16:20:51 -0400
Date: Mon, 12 Jul 2004 22:20:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: swsusp speeds
Message-ID: <20040712202034.GB862@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Vojtech asked me how fast swsusp actually is... So I did some timings
for your pleasure...

It *very* much depends on load. I have fairly minimal system with X
and rhytmbox as a test load.

Boot:	16 sec			(From enter in grub to login)  
Suspend:	13 sec, 13 sec
Resume:		27 sec, 20 sec	(From enter in grub to bash# prompt)

So yes, even on my machines boot is faster then resume, OTOH it takes
me quite long to login, relaunch X etc.

Oh and yes, I have pretty fast boot ;-) [system is centrino 1.4
notebook].

If your system is way slower than this, and you know how to make it
slow, tell me. (But I'm looking for a script to fill memory or
something, saying "just boot mandrake 17.9 and login into kde 15.3" is
not going to help).


								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
