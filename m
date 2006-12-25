Return-Path: <linux-kernel-owner+w=401wt.eu-S1751749AbWLYVCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWLYVCd (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 16:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754540AbWLYVCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 16:02:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36090 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751749AbWLYVCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 16:02:32 -0500
Date: Mon, 25 Dec 2006 22:02:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: swsusp testing wanted (was Re: Linux 2.6.20-rc2)
Message-ID: <20061225210207.GA2456@elf.ucw.cz>
References: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Rafael J. Wysocki (1):
>       ACPI: S4: Use "platform" rather than "shutdown" mode by default

...platform is right thing to do, but it is also "more aggresive" than
"shutdown" -- it needs bigger chunk of ACPI BIOS to work properly.

So, it would be nice to test 2.6.20-rc2 on your favourite system (if
it breaks, try if echo "shutdown" > /sys/power/disk fixes it), and
report results. Thanks,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
