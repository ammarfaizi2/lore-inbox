Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270818AbTGNUN3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270811AbTGNUMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:12:01 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:52959 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S270798AbTGNUJS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:09:18 -0400
Date: Tue, 15 Jul 2003 08:21:26 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
In-reply-to: <20030714201056.GB24964@ucw.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pavel Machek <pavel@suse.cz>, Jamie Lokier <jamie@shareable.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1058214085.3986.4.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1057963547.3207.22.camel@laptop-linux>
 <20030712140057.GC284@elf.ucw.cz> <200307121734.29941.dtor_core@ameritech.net>
 <20030712225143.GA1508@elf.ucw.cz> <20030713133517.GD19132@mail.jlokier.co.uk>
 <20030713193114.GD570@elf.ucw.cz> <20030714201056.GB24964@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's too easy to accidentally cancel a suspend then. There's also the
fact that when debugging is compiled in, other keys are used to control
the debug output: digits set the loglevel, R toggles rebooting and pause
or break toggles pausing between steps (two keys because kdb might be
using pause). I bet Pavel won't like them either, but I've found them
invaluable for debugging and using SysRq combinations resulted in
post-resume problems with the keyboard driver sometimes thinking SysRq
was still being pressed.

Regards,

Nigel

On Tue, 2003-07-15 at 08:10, Vojtech Pavlik wrote:
> How about making it to be any key?
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

