Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282525AbRKZUO4>; Mon, 26 Nov 2001 15:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282481AbRKZUNf>; Mon, 26 Nov 2001 15:13:35 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:43394 "EHLO
	Elf.ucw.cz") by vger.kernel.org with ESMTP id <S282466AbRKZUMu>;
	Mon, 26 Nov 2001 15:12:50 -0500
Date: Mon, 26 Nov 2001 21:06:21 +0100
From: Pavel Machek <pavel@suse.cz>
To: mj@ucw.cz, kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Restoring videomode on return from S3 sleep
Message-ID: <20011126210621.A2039@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'll need to restore video mode on returning from acpi sleep...

Unfortunately, video selection code is not part of kernel, it is
16-bit code. acpi_wakeup.S, otoh, *is* part of kernel :-(. Plus, I
can't find place where video.S passes number of mode it actually
*used*.

Any ideas?
								Pavel
-- 
<sig in construction>
