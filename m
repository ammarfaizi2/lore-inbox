Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286825AbSCKSdG>; Mon, 11 Mar 2002 13:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286959AbSCKSc5>; Mon, 11 Mar 2002 13:32:57 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:17422 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S286825AbSCKScu>;
	Mon, 11 Mar 2002 13:32:50 -0500
Date: Sun, 10 Mar 2002 23:00:57 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@suse.de>, kernel list <linux-kernel@vger.kernel.org>
Subject: strange dmesg output on athlon notebook
Message-ID: <20020310220056.GA189@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I see this in syslog:

CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
Enabling disabled K7/SSE Support.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1c7fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c7fbff 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Before vendor init, caps: 0383fbff c1c7fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1c7fbff 00000000 00000000
Intel machine check reporting enabled on CPU#0.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CPU:     After generic, caps: 0383fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c7fbff 00000000 00000000


Why _Intel_ machine check? And why it says  CPU: After vendor init
twice? [This is 2.5.6-acpi...]
								Pavel

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
