Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270641AbUJUKgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270641AbUJUKgn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270672AbUJUKeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:34:02 -0400
Received: from gprs214-68.eurotel.cz ([160.218.214.68]:49536 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S270641AbUJUKTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:19:53 -0400
Date: Thu, 21 Oct 2004 12:19:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nate Lawson <nate@root.org>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Machines self-power-up with 2.6.9-rc3 (evo N620c, ASUS, ...)
Message-ID: <20041021101937.GD21373@elf.ucw.cz>
References: <20041020191531.GC21315@elf.ucw.cz> <1098311478.4989.100.camel@desktop.cunninghams> <20041020225639.GD29863@elf.ucw.cz> <4176FCB8.3060103@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4176FCB8.3060103@root.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>I'm seeing bad problem with N620c notebook (and have reports of more
> >>>machines behaving like this, for example ASUS L8400C.) If I shutdown
> >>>machine with lid closed, opening lid will power the machine up. Ouch.
> >>>2.6.7 behaves okay.
> >>
> >>:> Some people would love to have the machine power up when they open
> >>the lid! Wish my XE3 would do that!
> 
> This problem sounds like a wake GPE is enabled for the lid switch and 
> that it has a _PRW that indicates it can wake the system from S5.  If 
> this is the case, just disabled the GPE.

I tried disabling all events in /proc/acpi/wakeup, and that did not
change anything.

> >:-). Well for some other people it powers up when they unplug AC
> >power, and *that* is nasty. I'd like my machine to stay powered down
> >when I tell it so.
> 
> This is likely a similar GPE problem.  The GPE for the EC fires even in 
> S5.  I think the EC GPE should be disabled in the suspend method.

How did this hangling changed between 2.6.7 and 2.6.9?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
