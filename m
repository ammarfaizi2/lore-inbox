Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbTJNLCc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 07:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbTJNLCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 07:02:32 -0400
Received: from gprs145-216.eurotel.cz ([160.218.145.216]:32901 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262282AbTJNLCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 07:02:31 -0400
Date: Tue, 14 Oct 2003 13:02:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: George Anzinger <george@mvista.com>
Cc: "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] VST (tick elimination) is now available
Message-ID: <20031014110218.GA20211@elf.ucw.cz>
References: <3F873067.9020805@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F873067.9020805@mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The first release of the VST package is now available.  VST or 
> Variable Scheduling Timeouts (or if you prefer, Variable Sleep Times) 
> contains code that, from the idle task, scans the timer list and, if 
> no timer is near, skips the timer interrupts that would otherwise be 
> generated.  The patch name is hrtimers-vst-*
> 
> The net result is that a quite system will use far less power as it 
> does not need to wake up ever 1/HZ timer tick.

Do you have some measurements of how much power does it save? Making
Sharp Zaurus run longer on batteries would certainly be nice ;-).
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
