Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272109AbRHVUB5>; Wed, 22 Aug 2001 16:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272108AbRHVUBr>; Wed, 22 Aug 2001 16:01:47 -0400
Received: from mpdr0.cleveland.oh.ameritech.net ([206.141.223.14]:36295 "EHLO
	mailhost.cle.ameritech.net") by vger.kernel.org with ESMTP
	id <S272103AbRHVUBn>; Wed, 22 Aug 2001 16:01:43 -0400
Date: Wed, 22 Aug 2001 12:05:01 -0400 (EDT)
From: Stephen Torri <storri@ameritech.net>
X-X-Sender: <torri@base.torri.linux>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.8-ac7: all serial ports not setup
Message-ID: <Pine.LNX.4.33.0108221201210.8546-100000@base.torri.linux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using 2.4.8-ac7 on a Dual P3@450Mhz. The machine has two serial
ports. ttyS0 & ttyS2 are covered by the first with ttyS1 & ttyS3 covered
by the second. Now typically in /proc/interrupts only one serial port is
configured. The IRQs 3 & 4 are shared by the two ports. Its not consistent
which one gets which IRQ. Sometimes the first has 3 and the second 4.
Today the situation is reversed. This ofcourse is wreaking havoc on
setting my pilot for synchronization.

Is there a options that I failed to select while configuring the kernel?
Do I need to add an option to the boot via lilo?

I will do an idiot check by checking the bios.

Stephen

