Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUFWXQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUFWXQX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 19:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUFWXQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 19:16:23 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:43773 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262114AbUFWXQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 19:16:21 -0400
Message-ID: <40DA0F42.9060802@nortelnetworks.com>
Date: Wed, 23 Jun 2004 19:16:18 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: BUG: kernel panic at startup, 2.6.7 on x86
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried syncing with 2.6.7 bk version, compiled with my 2.6.5 config, installed, 
and rebooted.  Everything was okay up to the point where it runs a script to set 
up my dsl connection.  At that point I got the following on the console:

"Starting adsl: Kernel panic: Aiee, killing interrupt handler!  In interrupt 
handler -- not syncing."

Unfortunately, that was all I got.

Here's the output of lspci.  Note, the linksys cards use the tulip driver.

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master 
IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:08.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet 10/100 
model NC100 (rev 11)
00:09.0 SCSI storage controller: Advanced System Products, Inc ABP940-U / 
ABP960-U (rev 03)
00:0b.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet 10/100 
model NC100 (rev 11)
00:0d.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear 
SoundFusion Audio Accelerator] (rev 01)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] 
(rev a1)

If you need any more information, just let me know and I'll see what I can do.

Chris
