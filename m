Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267751AbUG3RI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267751AbUG3RI2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 13:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267747AbUG3RGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 13:06:44 -0400
Received: from cantor.suse.de ([195.135.220.2]:4495 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267754AbUG3RGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 13:06:20 -0400
Date: Fri, 30 Jul 2004 19:03:15 +0200
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation fix for NMI watchdog
Message-Id: <20040730190315.7046caa7.ak@suse.de>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sync nmi_watchdog.txt with reality on x86-64.

diff -urpN -X ../KDIFX linux-2.6.8rc2-mm1/Documentation/nmi_watchdog.txt linux-2.6.8rc2-mm1-amd64/Documentation/nmi_watchdog.txt
--- linux-2.6.8rc2-mm1/Documentation/nmi_watchdog.txt	2004-03-21 21:12:12.000000000 +0100
+++ linux-2.6.8rc2-mm1-amd64/Documentation/nmi_watchdog.txt	2004-07-30 17:02:49.000000000 +0200
@@ -58,6 +58,9 @@ NOTE: starting with 2.4.2-ac18 the NMI-o
 you have to enable it with a boot time parameter.  Prior to 2.4.2-ac18
 the NMI-oopser is enabled unconditionally on x86 SMP boxes.
 
+On x86-64 the NMI oopser is on by default. On 64bit Intel CPUs 
+it uses IO-APIC by default and on AMD it uses local APIC.
+
 [ feel free to send bug reports, suggestions and patches to
   Ingo Molnar <mingo@redhat.com> or the Linux SMP mailing
   list at <linux-smp@vger.kernel.org> ]
