Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbTHOLcr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 07:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTHOLcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 07:32:47 -0400
Received: from h000.c007.snv.cp.net ([209.228.33.228]:43430 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id S263597AbTHOLcq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 07:32:46 -0400
X-Sent: 15 Aug 2003 11:32:44 GMT
Date: Fri, 15 Aug 2003 13:32:54 +0200
From: Uberto Barbini <uberto@ubiland.net>
X-Mailer: The Bat! (v1.62i) Personal
Reply-To: Uberto Barbini <uberto@ubiland.net>
X-Priority: 3 (Normal)
Message-ID: <188187847079.20030815133254@ubiland.net>
To: linux-kernel@vger.kernel.org
Subject: Mtrr problem on via M10000 with 2.6.0-test3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every time, X (4.3.99.10) reports at starting:

(WW) via(0): "Failed to setup write-combining range(0xe4000000,0x4000000)

The same error appears with vesa driver too.
I enabled mtrr in kernel and tried

less /proc/mtrr

...
reg03: base=0e40000000 (3648MB), size= 8MB: write-combining, count=1

The values seem right.
I also tried to change the ram amount for the video card (8-64) on bios and
it'll report correctly.

The problem is present at least since 2.6.0-test1, and with all X
versions.

Some other informations: I'm using gentoo and loaded via_agp and
agpgart, apart the error X runs nicely at first but after some time it
freeze all (telnet not responding).

Thanks for any hints or help.

Uberto Barbini

