Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbTI1XIc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 19:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbTI1XIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 19:08:32 -0400
Received: from host3.whitb.cust.sover.net ([207.136.236.67]:54669 "EHLO
	patternbook.com") by vger.kernel.org with ESMTP id S262767AbTI1XIa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 19:08:30 -0400
Date: Sun, 28 Sep 2003 19:08:29 -0400
From: Whit Blauvelt <whit@transpect.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Strange active ftp failure - adendum
Message-ID: <20030928230829.GA13971@free.transpect.com>
References: <20030928200226.GA13382@free.transpect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030928200226.GA13382@free.transpect.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A bit more experience, a few more details:

To try to pinpoint whether the smp code was involved, I read the SMP HOWTO,
then built a non-smp 2.4.22 kernel (make mrproper; copy in prior .config
file and deselect smp with make menuconfig; make bzImage; make modules; make
modules_install; plus appropriate LILO steps). The SMP HOWTO suggests this
should have worked. However the resulting kernel panics.

Call employee closer to office (I'm remote) to go in and reboot to working
2.4.20 (smp) kernel (after confirming panic). Surprisingly, now active ftp
is working on both lines. 

The machine has been rebooted before - although only a half-dozen times
since the active ftp problem became apparent - and the second-line active
ftp failure has been consistent. What could happen only sometimes in bootup
that would enable/disable it? I still need to find a better option than
"Reboot, test active ftp on second line, if not working then repeat."

Thanks,
Whit

