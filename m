Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262879AbTDAWCp>; Tue, 1 Apr 2003 17:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262881AbTDAWCp>; Tue, 1 Apr 2003 17:02:45 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:25023 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S262879AbTDAWCn>; Tue, 1 Apr 2003 17:02:43 -0500
Subject: cpufreq: scaling_governor=powersave produces time warp
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1049235186.637.20.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 02 Apr 2003 00:13:07 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On my Pentium IV 2Ghz and Intel i845 motherboard, adjusting the CPU
Frequency with:

echo powersave > /sys/devices/sys/cpu0/cpufreq/scaling_governor

makes the system clock start skewing into the future at a very fast
rate: the clock time advances at approximately ten times its normal
speed (one minute of system clock flies by in less than 5 seconds of
real time). Adjusting scaling_governor back to "performance" fixes the
problem.

Is this a bug? Am I doing something wrong?

Thanks!

________________________________________________________________________
        Felipe Alfaro Solana
   Linux Registered User #287198
http://counter.li.org

