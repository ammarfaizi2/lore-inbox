Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270426AbTGUU1Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 16:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270693AbTGUU1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 16:27:16 -0400
Received: from co239024-a.almel1.ov.home.nl ([217.120.226.100]:50564 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270426AbTGUU1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 16:27:07 -0400
Date: Mon, 21 Jul 2003 22:40:35 +0200 (CEST)
From: Aschwin Marsman <a.marsman@aYniK.com>
X-X-Sender: marsman@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-pre7: are security issues solved?
Message-ID: <Pine.LNX.4.44.0307212234390.3580-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Red Hat has released a new kernel today, that fixes several security issues.
I currently use 2.4.22-pre7, are those security issues solved in this kernel
too? Below are the descriptions from the errata:

> CAN-2003-0461: /proc/tty/driver/serial reveals the exact character counts
> for serial links. This could be used by a local attacker to infer password
> lengths and inter-keystroke timings during password entry.

> CAN-2003-0462: Paul Starzetz discovered a file read race condition existing
> in the execve() system call, which could cause a local crash.

> CAN-2003-0464: A recent change in the RPC code set the reuse flag on
> newly-created sockets. Olaf Kirch noticed that his could allow normal
> users to bind to UDP ports used for services such as nfsd.

> CAN-2003-0476: The execve system call in Linux 2.4.x records the file
> descriptor of the executable process in the file table of the calling
> process, allowing local users to gain read access to restricted file
> descriptors.

> CAN-2003-0501: The /proc filesystem in Linux allows local users to obtain
> sensitive information by opening various entries in /proc/self before
> executing a setuid program. This causes the program to fail to change the
> ownership and permissions of already opened entries.

> CAN-2003-0550: The STP protocol is known to have no security, which could
> allow attackers to alter the bridge topology. STP is now turned off by
> default.

> CAN-2003-0551: STP input processing was lax in its length checking, which
> could lead to a denial of service.

> CAN-2003-0552: Jerry Kreuscher discovered that the Forwarding table could
> be spoofed by sending forged packets with bogus source addresses the same
> as the local host. 

Have fun,
 
Aschwin Marsman
 
--
aYniK Software Solutions         all You need is Knowledge
P.O. box 134                     NL-7600 AC Almelo - the Netherlands
a.marsman@aYniK.com              http://www.aYniK.com

