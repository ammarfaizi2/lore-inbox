Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267446AbUBSRyG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 12:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267449AbUBSRyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 12:54:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:57011 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267446AbUBSRyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 12:54:00 -0500
X-Authenticated: #2027583
Subject: Problems booting with Kernel 2.6.2: filesystem is mounted read-only
From: Cedric Laczny <Cedric.Laczny@gmx.de>
Reply-To: Cedric.Laczny@gmx.de
To: linux-kernel@vger.kernel.org
Cc: Cedric.Laczny@gmx.de
Content-Type: text/plain
Message-Id: <1077213237.4213.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 19 Feb 2004 18:53:57 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm totally new in compiling a kernel, but apperantly (all make commands
went trough without complaining:) ) I made it to compile my own kernel
2.6.2 on Fedora Core1.
It even does boot, using grub, but after searching or intialising the
main hardware, it doesn't get write permission. It's copmplaining that
the filesystem is read-only...
I erased the "ro" option from grub.conf, but nothing changed. Givin it
the "rw" option brings e2fsck to complain but doesn't boot up completly
either.
Unfortunately I can't get a log of the failures, because it hangs during
initialising the "Systemlogger". Before that, it starts kudzu, tries to
acces some ksyms files in /var, initializes the eth0 interface and can't
initialize the ppp0 interface.

Booting my 2.4.22 unchanged Fedora Core1 kernel works totally fine.

Anyone an idea, what to do, or what I've could have done wrong during
compiling?


Best regards,


Cedric Laczny

