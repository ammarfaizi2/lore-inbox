Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264347AbUAIXXi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 18:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbUAIXXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 18:23:38 -0500
Received: from mail6.speakeasy.net ([216.254.0.206]:21176 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP id S264347AbUAIXXh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 18:23:37 -0500
X-AmikaGuardian-Id: mail6.speakeasy.net107369061626125267
X-AmikaGuardian-Action: Do Nothing()
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Aaron Burt <aaron@speakeasy.org>
Newsgroups: local.linux-kernel
Subject: ALSA: bad sound with low CPU load
Date: Fri, 9 Jan 2004 23:23:35 +0000 (UTC)
Organization: The Aluminum Bavariati
Message-ID: <slrnbvudvn.5ic.aaron@aluminum.bavariati.org>
NNTP-Posting-Host: aluminum.bavariati.org
X-Trace: aluminum.bavariati.org 1073690615 7101 127.0.0.1 (9 Jan 2004 23:23:35 GMT)
X-Complaints-To: news
NNTP-Posting-Date: Fri, 9 Jan 2004 23:23:35 +0000 (UTC)
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Basically, sound comes out as a hissing, garbled mess *unless* I load
down the CPU.  A kernel compile seems to do nicely for this purpose.

I've been seeing this behavior in the late 2.6.0-pre kernels through
2.6.1 plain and -mm1.  It happens with preempt and HPET both enabled
and disabled.  I haven't yet found what exact kernel version the
problem starts with, and I get no sound with the OSS drivers, so I
can't test them ATM.  I plan to narrow things down if possible, but
that takes time.

System is an Athlon at 1145 MHz on an ECS K7S5A (SiS 735 chipset)
running Debian Sid with ALSA-base v0.9.8-3.  The problem happens both
with the onboard i810-compatible sound and a CM8738 PCI sound board.
(Note that both are fixed at 48000 Hz.)  I'm tempted to buy 'n' try a
SoundBlaster-PCI card from FreeGeek.

I'd be happy to provide further info, but didn't want to start out
with a super-long message for something that may be obvious, if not
visible in Google or LKML.  Please reply to the list; I'm subscribed.

Thanks in advance,
  Aaron
