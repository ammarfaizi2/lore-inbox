Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbTFQVME (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 17:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264985AbTFQVME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 17:12:04 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:64136 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S264984AbTFQVMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 17:12:01 -0400
Subject: [PATCHSET] 2.4.21-dis4 released
From: Disconnect <kernel@gotontheinter.net>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1055884662.5031.15.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 17 Jun 2003 17:17:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.gotontheinter.net/kernel/

Highlights (* updated):
 * ACPI 2003-05-23
 * Software Suspend 1.0_pre9 with (newly required) swsusp.c
 * CPUfreq
 * Orinoco Monitor Mode 0.13b
 * ATI Radeon Mobility framebuffer update (from benh)
 * Don't allow ACPI S4 sleep unless swsusp is compiled in
 - Optional Inspiron I8500 DSDT
 - Don't deadlock when creating ext3 journal at mount time
 - Optionally disable trackpad while typing (2003-05-27)
 - Netdev-Random to allow NICs to contribute to random pool
 - Vfat-Symlinks to let vfat show .lnk files as symlinks
 - O_STREAMING to allow manual drop-behind of page cache (for multimedia
and other 'read one and throw away' access methods)
 - BCM4400 integrated

As before, there is a custom ACPI DSDT included for the Inspiron 8500;
be sure not to enable that (inside make config/menuconfig/xconfig) on
any other machine!

All the notes/details/etc are at http://www.gotontheinter.net/kernel/. 
The patch is against 2.4.21-pre8 (released as 2.4.21) and builds cleanly
with gcc-3.3 (gcc-3.2 is no longer recommended, gcc-2.95.3 is still the
baseline)

Now that I've got it into source management, if there is interest I will
add split patches to the website for a 'mix and match' approach.

For -dis5, coming to a webserver near you sometime soon, expect:
 + Supermount
 + preempt
 + low-latency
 + ..? feedback welcome

-- 
Disconnect <kernel@gotontheinter.net>

