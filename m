Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264309AbTKUGGH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 01:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264310AbTKUGGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 01:06:07 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:51204 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S264309AbTKUGGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 01:06:04 -0500
Date: Fri, 21 Nov 2003 07:05:45 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9-mm4: page allocation failure. order 3, mode 0x20
Message-ID: <20031121060545.GA6847@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After several runs of cdda2wav I get this message:

Nov 21 07:03:34 middle kernel: cdda2wav: page allocation failure. order:3, mode:0x20
Nov 21 07:03:34 middle last message repeated 36 times

MemTotal:      1032740 kB
MemFree:          4212 kB
Buffers:         21952 kB
Cached:         909920 kB
SwapCached:          0 kB
Active:         243228 kB
Inactive:       744460 kB
HighTotal:      131008 kB
HighFree:          252 kB
LowTotal:       901732 kB
LowFree:          3960 kB
SwapTotal:     4016232 kB
SwapFree:      4016232 kB
Dirty:           66352 kB
Writeback:           0 kB
Mapped:          64664 kB
Slab:            25816 kB
Committed_AS:    64280 kB
PageTables:        616 kB
VmallocTotal:   106488 kB
VmallocUsed:     40972 kB
VmallocChunk:    65516 kB

I ran cdda2wav a lot more under 2.9.0-test9-mm3 and didn't see this
message.

Kind regards,
Jurriaan
-- 
And though kids scrawl frustration on the back street wall
Most of them can't even spell bastard
	New Model Army - Master Race
Debian (Unstable) GNU/Linux 2.6.0-test9-mm3 4276 bogomips 0.81 0.57
