Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUBWNdj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 08:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbUBWNdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 08:33:38 -0500
Received: from spot.plotinka.ru ([212.220.30.16]:47799 "EHLO spot.plotinka.ru")
	by vger.kernel.org with ESMTP id S261851AbUBWNd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 08:33:28 -0500
Date: Mon, 23 Feb 2004 18:33:18 +0500
From: m0sia <m0sia@plotinka.ru>
To: linux-kernel@vger.kernel.org
Subject: Crazy mouse.
Message-Id: <20040223183318.6f6f739f@m0sia>
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm tried using kernels
2.6.1,2.6.1-mm3,2.6.1-love3,2.6.3-mm1,2.6.3-love3 & etc. Everywhere i
had a same problem. 

"psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization,
throwing 2 bytes away."

after that mouse going crazy. 

on kernaltrap i read:

"Problem:
~~~~~~~~

I'm getting these:

	psmouse.c: PS/2 mouse at serio0 lost synchronization, throwing 2 bytes
away.

Solution:
~~~~~~~~~

Check your mouse cable. If this only happens when you move your mouse in
a certain way, fix the mouse cable or replace the mouse.

Check your kernel and harddisk settings. This message can also happen
when the mouse interrupt is delayed more than one half of a second. Make
sure DMA is enabled for your harddrive and CD-ROM. Kill your ACPI/APM
battery monitoring applet. Try disabling ACPI, frequency scaling. Make
sure your time is ticking correctly, often with frequency scaling it
gets unreliable. Even if you're using the ACPI PM Timer as a clock
source - actually this often leads to the above problem. "

i disabled acpi,frequency scaling, enabled dma & etc, but the problem
still alive. 

on irc someone said, that it is X11 problem. 

what to do? i simply want my ps/2 mouse work correct. is it very
difficult to write not buggy psmouse module?
