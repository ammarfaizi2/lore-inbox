Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUJTXEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUJTXEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269043AbUJTXB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:01:27 -0400
Received: from gprs214-102.eurotel.cz ([160.218.214.102]:7296 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S270268AbUJTW7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:59:24 -0400
Date: Thu, 21 Oct 2004 00:59:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Hiroshi 2 Itoh <HIROIT@jp.ibm.com>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       acpi-devel-admin@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Machines self-power-up with 2.6.9-rc3 (evo N620c, ASUS, ...)
Message-ID: <20041020225910.GE29863@elf.ucw.cz>
References: <20041020191531.GC21315@elf.ucw.cz> <OF014FB65F.1C41FFC8-ON49256F33.007639BA-49256F33.0079C800@jp.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF014FB65F.1C41FFC8-ON49256F33.007639BA-49256F33.0079C800@jp.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Thanks for your report. I have some suggestions to identify your
> problem and help ACPI developers to work more effectively.
> 
> The developers are working both fixing ACPI related bugs and applying
> work around for bad BIOS behaviors. At this time I think fixing
> bugs is more important than applying work around.
> 
> So if your problem on some machine is so serious, could you please
> give us the BIOS version and whether the machine suspend/resume is
> OK in ACPI mode of Windows 2000/XP too? Of course DSDT table check
> is highly helpful. http://bugzilla.kernel.org/ is prepared for such
> purpose.

I was not talking about suspend/resume here, it wakes up even after
plain /sbin/shutdown -h now. I do not have Windows here to try, but it
works well in 2.6.7... 

								Pavel

> > I'm seeing bad problem with N620c notebook (and have reports of more
> > machines behaving like this, for example ASUS L8400C.) If I shutdown
> > machine with lid closed, opening lid will power the machine up. Ouch.
> > 2.6.7 behaves okay.
> >
> > Ouch, acpi=off makes it even worse [2.6.9-rc3, N620c]. I get some very
> > strange show on the leds (battery charge led blinks fast?!), then
> > machine powers up itself. This happens even with lid initially
> > open. 2.6.7 works as expected.
> >
> > Any ideas?


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
