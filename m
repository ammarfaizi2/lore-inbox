Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269455AbTGLHqr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 03:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269587AbTGLHqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 03:46:33 -0400
Received: from [158.152.209.66] ([158.152.209.66]:8108 "EHLO mauve.demon.co.uk")
	by vger.kernel.org with ESMTP id S269455AbTGLHqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 03:46:31 -0400
From: root@mauve.demon.co.uk
Message-Id: <200307120801.JAA14036@mauve.demon.co.uk>
Subject: 2.4.22-pre4 ACPI problems (toshiba 3110ct)
To: linux-kernel@vger.kernel.org
Date: Sat, 12 Jul 2003 09:00:53 +0100 (BST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have recently installed 2.4.22-pre4, after briefly testing 
2.5.72 in the hopes of better battery life than 2.4.20.

I have found a couple of issues that I'm wondering about.

When compiling, it's only possible to build ACPI into the kernel.
If you then choose to build things (battery, ac adaptor) into modules,
they won't install.

On the flip-side, /proc/acpi/battery/BAT1/info now seems to change
based on the battery that is installed when it does not on 2.5.72.

echo 4 >/proc/acpi/sleep

seems to work much more reliably than it did under 2.5.72.
I have not (as of yet, about 10 suspends) had it fail to recover.


(I cannot test as much as I might like at the moment, the hard drive
is becoming erattic, and I need to swap it out.)

