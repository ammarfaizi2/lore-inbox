Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269994AbUJTTTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269994AbUJTTTD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269048AbUJTTSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:18:04 -0400
Received: from gprs214-236.eurotel.cz ([160.218.214.236]:56707 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268884AbUJTTPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:15:45 -0400
Date: Wed, 20 Oct 2004 21:15:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Machines self-power-up with 2.6.9-rc3 (evo N620c, ASUS, ...)
Message-ID: <20041020191531.GC21315@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm seeing bad problem with N620c notebook (and have reports of more
machines behaving like this, for example ASUS L8400C.) If I shutdown
machine with lid closed, opening lid will power the machine up. Ouch.
2.6.7 behaves okay.

Ouch, acpi=off makes it even worse [2.6.9-rc3, N620c]. I get some very
strange show on the leds (battery charge led blinks fast?!), then
machine powers up itself. This happens even with lid initially
open. 2.6.7 works as expected.

Any ideas?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
