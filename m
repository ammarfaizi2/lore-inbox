Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbTJKPwO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 11:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbTJKPwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 11:52:14 -0400
Received: from mail.gmx.de ([213.165.64.20]:51357 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263149AbTJKPwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 11:52:12 -0400
X-Authenticated: #7204266
Date: Sat, 11 Oct 2003 16:52:24 +0100
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: How can I trace ACPI events?
From: Martin Aspeli <optilude@gmx.net>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <oprwvydmtg9y0cdf@mail.gmx.net>
User-Agent: Opera7.20/Win32 M2 build 3144
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm having trouble with ACPI on my Centrino notebook; if ACPI is disabled, 
a lot of my PCI devices (e.g. onboard sound) don't get any IRQ. If ACPI is 
enabled, the system boots fine, but about a minute after startup, for no 
obvious reason keventd ("events/0", PID 3) starts chewing 99.9% CPU and 
the fan starts spinning at maximum. This is with 2.6.0-test7, although 
I've had the same problem in all kernels I've tried on this box (from 
2.4.22-ac through from 2.6.0-test5 to -test7). Chris Wright suggested 
runaway ACPI events could cause events/0 to chew CPU, which seems 
consistent with what I'm seeing here.

If I am to diagnose it further, though, I'll have to figure out what ACPI 
events (if any) are causing the massive spikes in CPU usage. How can I 
trace this? I've had acpid running, but the log in /var/log/acpid only 
shows simple messages (started service, registered 1 rule). Nothing 
particularly interesting from dmesg or TTY 12, either.

CC'd replies would be appreciated.

Thanks,
Martin

