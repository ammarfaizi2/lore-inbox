Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314284AbSFISAv>; Sun, 9 Jun 2002 14:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314325AbSFISAt>; Sun, 9 Jun 2002 14:00:49 -0400
Received: from [195.39.17.254] ([195.39.17.254]:4002 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314284AbSFIR7c>;
	Sun, 9 Jun 2002 13:59:32 -0400
Date: Sun, 2 Jun 2002 16:22:32 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        ralf@gnu.org, rhw@memalpha.cx, mingo@redhat.com, paulus@samba.org,
        anton@samba.org, schwidefsky@de.ibm.com, bh@sgi.com, davem@redhat.com,
        ak@suse.de, torvalds@transmeta.com
Subject: Re: Hotplug CPU Boot Changes: BEWARE
Message-ID: <20020602162232.I219@toy.ucw.cz>
In-Reply-To: <E17GHB3-0000gD-00@wagner.rustcorp.com.au> <m1elfjw39n.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 	In writing the hotplug CPU stuff, Linus asked me to alter the
> > boot sequence to "plug in" CPUs.  I am shortly going to be sending
> > these patches to him now I have got my x86 box to boot with the
> > changes.
> 
> If to the general SMP case is added the ability to dynamically enable
> and disable cpus at runtime, this infrastructure work appears to have
> general applicability now.  Allowing for example dynamic
> enable/disable of HT on P4-Xeons at runtime for example.

Well, this way we can get suspend-to-{RAM,disk} for SMP... Offline all
other CPUS, do suspend, put them back online.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

