Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270020AbUJVH5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270020AbUJVH5k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 03:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269704AbUJVH4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 03:56:31 -0400
Received: from gprs214-34.eurotel.cz ([160.218.214.34]:35204 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269830AbUJVHyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 03:54:06 -0400
Date: Fri, 22 Oct 2004 09:53:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Li Shaohua <shaohua.li@intel.com>
Cc: Nate Lawson <nate@root.org>, Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Machines self-power-up with 2.6.9-rc3 (evo N620c, ASUS, ...)
Message-ID: <20041022075343.GC8376@elf.ucw.cz>
References: <4176FCB8.3060103@root.org> <1098323602.6132.51.camel@sli10-desk.sh.intel.com> <20041021103729.GA1088@elf.ucw.cz> <1098405352.28250.2.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098405352.28250.2.camel@sli10-desk.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > :-). Well for some other people it powers up when they unplug AC
> > > > > power, and *that* is nasty. I'd like my machine to stay powered down
> > > > > when I tell it so.
> > > > 
> > > > This is likely a similar GPE problem.  The GPE for the EC fires even
> > > > in 
> > > > S5.  I think the EC GPE should be disabled in the suspend method.
> > > It could be the wakeup GPE issue, but must note Pavel's system suffer
> > > the problem even with acpi=off. Could you please try boot your system
> > > with acpi=off, and then reboot with acpi=off, what's the result? I
> > > expected the wakeup GPE is disabled by the BIOS in this case.
> > > Anyway, the DSDT can tell us the wakeup GPE info.
> > 
> > You want me to boot with acpi=off twice and see if machine powers down
> > okay in second case?
> Yes, indeed.

Okay, I did poweron, boot with acpi=off, reboot (again with acpi=off),
then shutdown -h now. I got the same strange lightshow at the leds and
reboot instead of powerdown.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
