Return-Path: <linux-kernel-owner+willy=40w.ods.org-S274648AbVBFK3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274648AbVBFK3J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 05:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274980AbVBFK3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 05:29:08 -0500
Received: from gprs214-7.eurotel.cz ([160.218.214.7]:44206 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S274648AbVBFKZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 05:25:33 -0500
Date: Sun, 6 Feb 2005 11:25:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Tony Lindgren <tony@atomide.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick, version 050127-1
Message-ID: <20050206102503.GA1089@elf.ucw.cz>
References: <20050201230357.GH14274@atomide.com> <20050202141105.GA1316@elf.ucw.cz> <20050203030359.GL13984@atomide.com> <20050203105647.GA1369@elf.ucw.cz> <20050203164331.GE14325@atomide.com> <20050204051929.GO14325@atomide.com> <20050205230017.GA1070@elf.ucw.cz> <20050206023344.GA15853@atomide.com> <20050206081137.GA994@elf.ucw.cz> <1107679990.3532.37.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107679990.3532.37.camel@krustophenia.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I do have CONFIG_X86_PM_TIMER enabled, but it seems by board does not
> > have such piece of hardware:
> > 
> > pavel@amd:/usr/src/linux-mm$ dmesg | grep -i "time\|tick\|apic"
> > PCI: Setting latency timer of device 0000:00:11.5 to 64
> > pavel@amd:/usr/src/linux-mm$ 
> 
> If you are sure that machine supports ACPI, maybe this is your problem
> (from the POSIX high res timer patch):
> 
>           If you enable the ACPI pm timer and it cannot be found, it is
>           possible that your BIOS is not producing the ACPI table or
>           that your machine does not support ACPI.  In the former case,
>           see "Default ACPI pm timer address".  If the timer is not
>           found the boot will fail when trying to calibrate the 'delay'
>           loop.

Well, but how do I get the address? I'll try looking at BIOS
options...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
