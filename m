Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVF0SUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVF0SUs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 14:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVF0SUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 14:20:47 -0400
Received: from smtp04.mrf.mail.rcn.net ([207.172.4.63]:58980 "EHLO
	smtp04.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S261540AbVF0SUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 14:20:34 -0400
X-IronPort-AV: i="3.93,235,1115006400"; 
   d="scan'208"; a="52305408:sNHT24356632"
Subject: Newbie Roadmap?
From: Howard Owen <hbo@egbok.com>
To: LKML List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: EGBOK Consultants
Date: Mon, 27 Jun 2005 11:20:32 -0700
Message-Id: <1119896432.9541.88.camel@Quirk.egbok.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've embarked on a project to write device drivers for an obscure and
rare ISA card. It's a modern version of the HP 82973 HP-IL interface
produced by Cristoph Klug. HP-IL was a bit-serial, dog-slow version of
HP-IB (IEEE-488) that was designed to work with the HP-41C family of
calculators, and later with the HP-71 and HP-85. The 41C calculators are
my hobby interest. I'd like to introduce myself, and ask for pointers
for a newbie device driver author.

A little about me. I've been working in IT since before it was called
that. I started out in 1985, so that's 20 years. I've been a systems
engineer, then a systems administrator, then a systems engineer again,
then a systems architect. Those titles had various meanings at various
times, but the common denominator has always been systems, systems and
systems. I have little academic background, learning most of what I know
on the job, on line and at conferences, symposia and training courses.
The first kernel architecture I learned about was VAX/VMS 4. I've delved
deeper into BSD and Linux than any other kernel architectures, but it
has been only as a bug chaser. I've needed to understand the Red Hat
version of the 2.4 kernel at my most recent job in order to be able to
triage bugs and suggest solutions. My C programming skills are fair. I
can read kernel code, and with the help of LXR, I can gain some
understanding of what is going on. I probably know just enough to be
dangerous slinging my own code around. 8)

What I've done so far: I've picked up and started reading "Linux Device
Drivers" both editions 2 and 3. I'm about half way through Love's "Linux
Kernel Development" I've gotten my device to work under DOSEMU with its
userland port access. (The existing software is DOS) Using DOSEMU, I've
watched the dialog between the software and the card, and also with
external devices.  I've talked about the architecture with an interested
colleague and made some tentative choices on that front. I'm starting
out running Slack 10.1, so I'll probably tackle the 2.4 driver first.

At this juncture I'd like to start engaging with the wider community, to
make sure I'm not going too far astray. The current driver, once it's
finished, won't need wide distribution, since I'm sure there are fewer
than 100 boards in existence. But I'd like to write the driver as if it
were going to have a wide audience, both for the education in the
discipline of writing such things, and for the enjoyment of doing it the
right way.

If anyone has suggestions or pointers for a newbie with the above
background, I'd greatly appreciate hearing from you.

Thanks,
-- 
Howard Owen        hbo@egbok.com "Even if you are on the right
EGBOK Consultants Linux Architect track, you'll get run over if you
fwd:50279    pstn:+1-650-218-2216 just sit there." - Will Rogers

