Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262742AbTC0Ob0>; Thu, 27 Mar 2003 09:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262947AbTC0Ob0>; Thu, 27 Mar 2003 09:31:26 -0500
Received: from 64-238-252-21.arpa.kmcmail.net ([64.238.252.21]:53698 "EHLO
	kermit.unets.com") by vger.kernel.org with ESMTP id <S262742AbTC0ObW>;
	Thu, 27 Mar 2003 09:31:22 -0500
Subject: Kernel Itself Reports Bug, Continuous OOPS's, and Phantom NIC Card
From: Adam Voigt <adam@cryptocomm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Mar 2003 09:42:57 -0500
Message-Id: <1048776183.1873.2.camel@beowulf.cryptocomm.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 27 Mar 2003 14:42:36.0639 (UTC) FILETIME=[1BE5D6F0:01C2F46F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Distro: Redhat 8.0
Kernel: Redhat 2.4.18-27.8.0 (Latest)
Mobo: Aptron P4VXAD
CPU: 2.4 GHZ Intel Pentium 4
RAM: 512 MB
Kernel Params: ide=nodma, pci=biosirq (the dmesg suggested it =))

Leaving the computer running all night, with only a CPU
intensive task (i.e., seti@home), produced the attached
message log, of what appear to be almost on-the-clock
hourly OOPS's. This ofcourse led me to believe it was something
in my cron schedule, only problem is, it's empty, so it's
either syslogd or a built in system hourly task (no problems
on 8 other machines with this same kernel, distro, and config).

Behavior with the OOPS's, is sporatic, I can turn the machine
on, wait ten minutes, and log in, and do a "ls" and it will
OOPS, other times it will be hours before I see them.

One other problem, probably unrelated, the BIOS and the Kernel
both report seeing a "Realtek 8139" NIC on the computer, though
no such card exists and it is not built onto the mobo, only a
3COM 3c59x (PCI Card).

Included in the messages the kernel seemed to want me to
report to the list two bug reports =), seeing as how it even
has "cut here" in the messages file. Attached, is the full
/var/log/message, at the end of the file, the machine just quit,
as when I came in, no display would come up. I've also attached
the output from dmesg, lsmod, and lspci, if you need anything else,
or have any ideas, PLEASE don't hesitate to tell me.

-- 
Adam Voigt (adam@cryptocomm.com)
The Cryptocomm Group
My GPG Key: http://64.238.252.49:8080/adam_at_cryptocomm.asc

