Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbVJBQxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVJBQxc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 12:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVJBQxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 12:53:32 -0400
Received: from odin.selfhtml.org ([213.198.84.177]:48791 "EHLO
	odin.selfhtml.org") by vger.kernel.org with ESMTP id S1751127AbVJBQxb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 12:53:31 -0400
Message-ID: <4340108F.7030604@selfhtml.org>
Date: Sun, 02 Oct 2005 18:53:35 +0200
From: Christian Seiler <christian.seiler@selfhtml.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050403)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug at mm/rmap.c:493, Kernel 2.6.13.2
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In the kernel log of a computer I'm administrating a strange message
appeared stating there was a kernel bug in mm/rmap.c, line 493. I put
together the kernel log message (including the stack trace), the kernel
configuration, the output of lspci -v, lsmod, uname -a and gcc/ld
-version here:

http://src.selfhtml.org/lkml/

Although the message says a reboot is needed, the server still seems to
work after that message (login using SSH is possible, all services still
respond normally). After a reboot the same message reappears inside the
log after some time.

The distribution is Gentoo Linux, but the kernel is built from vanilla
sources. The system is entirely 64bit - no 32bit libraries are
installed. The server itself is a Sun Fire V20z with two Opteron 244, 2
GiB of RAM and hardware RAID-1 with two U320 SCSI disks.

Regards,
Christian
