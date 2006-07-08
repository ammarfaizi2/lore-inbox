Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWGHO46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWGHO46 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 10:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWGHO46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 10:56:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19910 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964860AbWGHO46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 10:56:58 -0400
Date: Sat, 8 Jul 2006 16:55:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: pcmcia IDE broken in 2.6.18-rc1
Message-ID: <20060708145541.GA2079@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When I insert the card, I get

pccard: PCMCIA card inserted into slot 0
cs: memory probe 0xe8000000-0xefffffff: excluding
0xe8000000-0xefffffff
cs: memory probe 0xc0200000-0xcfffffff: excluding
0xc0200000-0xc11fffff 0xc1a00000-0xc61fffff 0xc6a00000-0xc71fffff
0xc7a00000-0xc81fffff 0xc8a00000-0xc91fffff 0xc9a00000-0xca1fffff
0xcaa00000-0xcb1fffff 0xcba00000-0xcc1fffff 0xcca00000-0xcd1fffff
0xcda00000-0xce1fffff 0xcea00000-0xcf1fffff 0xcfa00000-0xd01fffff
pcmcia: registering new device pcmcia0.0
PM: Adding info for pcmcia:0.0
ide2: I/O resource 0xF887E00E-0xF887E00E not free.
ide2: ports already in use, skipping probe
ide2: I/O resource 0xF887E01E-0xF887E01E not free.
ide2: ports already in use, skipping probe
...

it ends with

ide-cs: ide_register() at 0xf999c000 & 0xf999c00e, irq 7 failed

:-(. Back to 2.6.17 once again, I'm afraid...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
