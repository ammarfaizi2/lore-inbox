Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbTDTPAU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 11:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTDTPAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 11:00:20 -0400
Received: from franka.aracnet.com ([216.99.193.44]:50354 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263596AbTDTPAT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 11:00:19 -0400
Date: Sun, 20 Apr 2003 08:12:17 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 606] New: Hang occurs at reboot
Message-ID: <9990000.1050851537@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=606

           Summary: Hang occurs at reboot
    Kernel Version: 2.5.67 and earlier versions
            Status: NEW
          Severity: low
             Owner: mbligh@aracnet.com
         Submitter: m4341@abc.se


Distribution:
RedHat 8.0+ kernel 2.5.67, RootLinux 1.3

Hardware Environment:
HP Vectra XU 2*200MHz Pentium Pro, Mitac 8575 laptop P4, 2GHz

Software Environment:
Problem Description:
The system hangs instead of shut downs or reboots during a shutdown, but all
buffers are at least flushed since the filesystems are clean at bootup, so this
is a minor annoyance. There are however some differences: On the HP Vectra it is
not always a hang, while it is always a hang on the Mitac. But the 2.4 kernel
seems to reboot (the few times I had to revert) fine on both machines. It
doesn't seem like there is any difference between reboot and shutdown.

This problem was encountered on a Mitac 8575 laptop first, and there I
considered it as a possible odd hardware case, since even Windows XP hangs
occasionally on that machine during shutdown.

Workaround: Issue a hard reset, or a powerdown/powerup.


