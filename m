Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266118AbTGNURu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270827AbTGNUQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:16:26 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:63137 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270825AbTGNUPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:15:25 -0400
Date: Mon, 14 Jul 2003 22:29:47 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jamie Lokier <jamie@shareable.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030714202947.GH902@elf.ucw.cz>
References: <1057963547.3207.22.camel@laptop-linux> <20030712140057.GC284@elf.ucw.cz> <200307121734.29941.dtor_core@ameritech.net> <20030712225143.GA1508@elf.ucw.cz> <20030713133517.GD19132@mail.jlokier.co.uk> <20030713193114.GD570@elf.ucw.cz> <20030714201056.GB24964@ucw.cz> <1058214085.3986.4.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058214085.3986.4.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It's too easy to accidentally cancel a suspend then. There's also the
> fact that when debugging is compiled in, other keys are used to control
> the debug output: digits set the loglevel, R toggles rebooting and pause
> or break toggles pausing between steps (two keys because kdb might be
> using pause). I bet Pavel won't like them either, but I've found
> them

You won that bet. This kind of debugging stuff needs to be killed
before merging with Linus.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
