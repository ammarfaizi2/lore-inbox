Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbSKJLrZ>; Sun, 10 Nov 2002 06:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264838AbSKJLrZ>; Sun, 10 Nov 2002 06:47:25 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54546 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264836AbSKJLrY>; Sun, 10 Nov 2002 06:47:24 -0500
Date: Sun, 10 Nov 2002 12:54:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, Pavel Machek <pavel@ucw.cz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, benh@kernel.crashing.org,
       Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Message-ID: <20021110115408.GA22068@atrey.karlin.mff.cuni.cz>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A4C9@orsmsx119.jf.intel.com> <3205.1036707953@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3205.1036707953@passion.cambridge.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> But stuff like battery info in /proc/acpi just has no excuse.

Yes... But how should "generic" battery info look like?

On apm you only know percentages and ETA left.

On acpi you know voltages, capacities and present rate.

On zaurus you only know voltages.

It will be quite hard to decide "one correct interface". It should
probably be called "/proc/power".
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
