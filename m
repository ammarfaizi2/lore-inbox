Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161262AbWASIjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161262AbWASIjc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 03:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161274AbWASIjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 03:39:32 -0500
Received: from quasar.dynaweb.hu ([195.70.37.87]:52699 "EHLO quasar.dynaweb.hu")
	by vger.kernel.org with ESMTP id S1161262AbWASIjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 03:39:31 -0500
Date: Thu, 19 Jan 2006 11:08:34 +0100
From: Rumi Szabolcs <rumi_ml@rtfm.hu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x kernel uptime counter problem
Message-Id: <20060119110834.bb048266.rumi_ml@rtfm.hu>
X-Mailer: Sylpheed version 2.2.0beta4 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've got a Linux system running the 2.4.26 kernel which was about
to pass the 500 day mark these days and now suddenly what I see is
that the uptime counter has reset:

$ uname -a && w && cat /proc/uptime && last -1 reboot
Linux quasar 2.4.26 #3 SMP Tue Sep 7 09:22:08 CEST 2004 i686 Intel(R) Pentium(R) 4 CPU 2.60GHz GenuineIntel GNU/Linux
 09:38:08 up 1 day, 12:49,  5 users,  load average: 0.00, 0.00, 0.00
USER     TTY        LOGIN@   IDLE   JCPU   PCPU WHAT
rumi     pty/s0    08:53    0.00s  0.04s  0.02s screen -r
rumi     ttyp1     10Sep04 31:58   9:12   9:12  epic
rumi     ttyp3     Tue12   44:33m  0.01s  0.01s -/bin/bash
rumi     ttyp2     13Feb05  8days  0.11s  0.11s -/bin/bash
rumi     ttypc     11Dec05  0.00s  0.12s  0.11s -/bin/bash
132596.51 39801752.60
reboot   system boot  2.4.26           Tue Sep  7 18:47         (498+15:50)

>From the above it can be seen that the system is running continuously
and wasn't rebooted 36 hours ago as the uptime counter would suggest.

Is this a known bug?

Regards,

Sab
