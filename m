Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264513AbTIDCS7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264520AbTIDCS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:18:59 -0400
Received: from h214n1fls32o988.telia.com ([62.20.176.214]:51383 "EHLO
	procyon.nix.homeunix.net") by vger.kernel.org with ESMTP
	id S264513AbTIDCSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:18:42 -0400
Subject: PCMCIA and ACPI?
From: Henrik Persson <nix@syndicalist.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1062641921.3514.11.camel@h214n1fls32o988.telia.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 04 Sep 2003 04:18:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just booted Linux 2.6.0-test4 (plus all the patches found at
 (http://pcmcia.arm.linux.org.uk) with acpi=off and all of my problems 
disappeared except the "insert twice before you get a light"-issue..

This machine is an Acer Aspire 1300XV with this lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
00:11.0 ISA bridge: VIA Technologies, Inc. VT8231 [PCI-to-ISA Bridge]
(rev 10)
00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1e)
00:11.4 Bridge: VIA Technologies, Inc. VT8235 ACPI (rev 10)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686
AC97 Audio Controller (rev 40)
00:11.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97
Modem] (rev 20)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II]
(rev 51)
01:00.0 VGA compatible controller: S3 Inc. VT8636A [ProSavage KN133]
AGP4X VGA Controller (TwisterK) (rev 01)

I will play around with this some more after some sleep.

--
Henrik Persson

