Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbUC2CEd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 21:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbUC2CEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 21:04:33 -0500
Received: from aysen.dcsc.utfsm.cl ([200.1.21.90]:29865 "EHLO
	aysen.dcsc.utfsm.cl") by vger.kernel.org with ESMTP id S262536AbUC2CEa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 21:04:30 -0500
Subject: Bug report: Floppy driver freeze on SMP
From: Manuel Jander <mjander@users.sourceforge.net>
Reply-To: mjander@users.sourceforge.net
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1080526189.1675.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Sun, 28 Mar 2004 22:09:49 -0400
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3 similar computers i found this problem:

- Hardware A (two of them):
CPU: Dual Athlon MP 2100+ or MP 2400+
Mainboard: MSI K7D Master (AMD Opus chipset)
RAM: 2GiB DDR registered RAM.

- Hardware B (one of this):
CPU: Quad Pentium III Xeon
Mainboard: American Megatrend FX440 mainboard.
RAM: 2GiB DDR registered RAM.

- Software
Kernel: Any vanilla 2.4+XFS or 2.6 kernel.
OS: Debian GNU/Linux.

- How to reproduce:
Access floppy drive using mtools or mouting for 2-5 times and the system
locks up hard, with nothing responding. On a Computer with CPU activity
LED's, those LED's stopped flickering, which means that no single bit
continued working after the problem occurs.

- Comments:
I was unable to get any OOPS or backtrace since such info could not even
be written to the disk or screen.
I first though of a hardware specific issue, but since the new Athlon
MP's are behaving the same, it seems to be more widespread.

I would try to fix it myself, but i'm too busy fixing my own bugs on
other drivers :P

Best Regards

Manuel.


