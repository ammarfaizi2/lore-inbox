Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270850AbTG0P6Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 11:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270851AbTG0P6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 11:58:24 -0400
Received: from ws-han1.win-ip.dfn.de ([193.174.75.150]:40278 "EHLO
	ws-han1.win-ip.dfn.de") by vger.kernel.org with ESMTP
	id S270850AbTG0P6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 11:58:19 -0400
Date: Sun, 27 Jul 2003 18:14:06 +0200
Message-ID: <vines.sxdD+Cdz6zA@SZKOM.BFS.DE>
X-Priority: 3 (Normal)
To: <linux-kernel@vger.kernel.org>
From: <WHarms@bfs.de> (Walter Harms)
Reply-To: <WHarms@bfs.de>
Subject: inconsistant speed reporting
X-Incognito-SN: 25185
X-Incognito-Version: 5.1.0.84
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi all,
 i have noticed that the processor speed reported by the kernel is different. Here is a list that i have compiled on my notebook:

dmesg.2.4.19:      Detected 999.906 MHz processor.
dmesg.2.4.21:      Detected 1019.778 MHz processor.
dmesg.2.6.0:       Detected 999.927 MHz processor.
dmesg.2.6.0-a3:    Detected 999.903 MHz processor.

ACPI:
dmesg.2.4.21:..... CPU clock speed is 999.9308 MHz.
dmesg.2.6.0:..... CPU clock speed is 1329.0655 MHz.
dmesg.2.6.0-a3:..... CPU clock speed is 1329.0620 MHz.

ACPI:
dmesg.2.4.21:..... host bus clock speed is 133.3240 MHz.
dmesg.2.6.0:..... host bus clock speed is 177.0287 MHz.
dmesg.2.6.0-a3:..... host bus clock speed is 177.0282 MHz.


notebook:
acer tm 620
with
CPU: Intel(R) Pentium(R) III Mobile CPU      1000MHz stepping 01

btw: thx to the ACPI team without the ACPI patch (for 2.4.x)
its not possible to use the nb propperly.


walter
