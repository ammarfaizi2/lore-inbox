Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314095AbSEFFSn>; Mon, 6 May 2002 01:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSEFFSm>; Mon, 6 May 2002 01:18:42 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:34567 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S314095AbSEFFSl>; Mon, 6 May 2002 01:18:41 -0400
Date: Mon, 6 May 2002 07:18:32 +0200
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.13 error:  kswapd: page allocation failure. order:0 mode:0x20
Message-ID: <20020506051832.GA8595@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suddenly, after 36 hours uptime, the console was flooded with this
message.


May  6 06:54:24 alpha -- MARK --
May  6 07:11:28 alpha kernel: apd: page allocation failure. order:0, mode:0x20
May  6 07:11:28 alpha kernel: kswapd: page allocation failure. order:0, mode:0x20
May  6 07:11:28 alpha last message repeated 296 times
May  6 07:11:37 alpha kernel: x20
May  6 07:11:37 alpha kernel: ssh: page allocation failure. order:0, mode:0x20
May  6 07:11:37 alpha last message repeated 314 times
May  6 07:11:39 alpha kernel: apd: page allocation failure. order:0, mode:0x20
May  6 07:11:39 alpha kernel: kswapd: page allocation failure. order:0, mode:0x20
May  6 07:11:39 alpha last message repeated 296 times
May  6 07:11:39 alpha kernel: ssh: page allocation failure. order:0, mode:0x20
May  6 07:11:40 alpha last message repeated 73 times
May  6 07:11:46 alpha kernel: Kernel logging (proc) stopped.
May  6 07:11:46 alpha kernel: Kernel log daemon terminating.
May  6 07:11:46 alpha exiting on signal 15
May  6 07:13:35 alpha syslogd 1.4.1#10: restart.

Given the fact that this alpha has 1.5 Gb memory and 2 Gb swap, I feel
'out-of-memory' shouldn't happen (I was running mutt, slrn, some ssh
sessions - nothing big).

after reboot:
MemTotal:      1553808 kB
MemFree:       1397688 kB
MemShared:           0 kB
Buffers:         71584 kB
Cached:          23848 kB
SwapCached:          0 kB
Active:          25064 kB
Inactive:        92616 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      1553808 kB
LowFree:       1397688 kB
SwapTotal:     2292720 kB
SwapFree:      2292720 kB
Dirty:           14760 kB
Writeback:           0 kB

Is this report useful to someone? If more info is needed, just ask me.

Jurriaan
-- 
Cadets were humping in the corridors, a party of outraged Senators roamed
Krane barracks, everyone, including me, questioned orders, ...
Law and order.
	David Feintuch - Fisherman's Hope.
Debian GNU/Linux 2.5.13 on Alpha 988 bogomips load:0.00 0.00 0.00
