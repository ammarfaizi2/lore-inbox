Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265163AbUFROEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbUFROEE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 10:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265168AbUFROEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 10:04:04 -0400
Received: from vsmtp12.tin.it ([212.216.176.206]:23188 "EHLO vsmtp12.tin.it")
	by vger.kernel.org with ESMTP id S265163AbUFROEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 10:04:00 -0400
Subject: [BUG] 2.6.x ALSA sound is pretty broken
From: Hetfield <hetfield666@virgilio.it>
Reply-To: hetfield666@virgilio.it
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Hetfield
Message-Id: <1087567432.9282.17.camel@blight.blight>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 16:03:53 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i've got hard problems with sound in all 2.6.x, even 2.6.7 kernels.

with 2.4.2x or windows i've got no problems, so i'm sure it's kernel and
not hardware related.

the problem is that sound jumps, flickers and isn't good when harddisk
reads lots of data (i mean not 1-2mb but 60-100mb and more)

i checked irq and there is not conflict, i setted a higher and lower
value of latency and nothing changed.

i've the same problems since 2.6.0 kernels. Vanilla and Gentoo too.
I've tried lots of solutions, like disabling preemptile kernel, adding
alsa and oss, only oss, only alsa, as module or built-in.
nothing changes.

my audio card is a Creative SB PCI128, found by linux as


0000:00:0b.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev
01)
        Subsystem: Unknown device 4942:4c4c
        Flags: bus master, slow devsel, latency 32, IRQ 10
        I/O ports at b000

while on Windows i use es1371/3 drivers.
however with 2.4.x i always used es1370 alsa module without problems.
When harddisk is sleeping sound is normally good.

Thanks for support

