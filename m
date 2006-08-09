Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWHIM65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWHIM65 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWHIM6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:58:55 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61150 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750740AbWHIM6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:58:54 -0400
Date: Wed, 9 Aug 2006 14:58:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net,
       linux-pm@osdl.org, ncunningham@linuxmail.org
Subject: Re: swsusp and suspend2 like to overheat my laptop
Message-ID: <20060809125840.GD3808@elf.ucw.cz>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com> <20060808235352.GA4751@elf.ucw.cz> <Pine.LNX.4.58.0608082215090.20396@gandalf.stny.rr.com> <20060809073958.GK4886@elf.ucw.cz> <Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com> <Pine.LNX.4.58.0608090751340.2500@gandalf.stny.rr.com> <20060809120844.GD3747@elf.ucw.cz> <Pine.LNX.4.58.0608090831440.3177@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0608090831440.3177@gandalf.stny.rr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-08-09 08:35:47, Steven Rostedt wrote:
> 
> On Wed, 9 Aug 2006, Pavel Machek wrote:
> 
> >
> > Okay, run top to see what goes on, and look for
> > /proc/acpi/processor/*/* -- you are interested in C states before and
> > after suspend.
> 
> I don't quite understand.  What am I looking for in top?

Some process that is running and eating 99% cpu when it should not be
running and doing anything?
								Pavel


> Here's the before and after:
> 
> before:
> 
> $ grep C /proc/acpi/processor/*/*
> /proc/acpi/processor/CPU0/power:active state:            C1
> /proc/acpi/processor/CPU0/power:max_cstate:              C8
> /proc/acpi/processor/CPU0/power:   *C1:                  type[C1]
> promotion[--] demotion[--] latency[000] usage[00000000] duration[00000000000000000000]

All zeros? Strange...
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
