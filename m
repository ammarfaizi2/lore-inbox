Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269602AbTG1NPm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 09:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269670AbTG1NOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 09:14:16 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:35255 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S269602AbTG1NNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 09:13:46 -0400
Message-ID: <3F252538.3010701@gmx.de>
Date: Mon, 28 Jul 2003 15:29:28 +0200
From: hal-9000-@t-online.de (thorstenk)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030514
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-1/2 reboots out of the blue
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: XLn5-yZloeg4Jfs7HweblLJ654w+2OfPYOjAyCf4e6qTpJ5jaH+Gk2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > hi,
 > every time I try to run 2.6.0test1/2, the first couple of minutes all 
went
 > well, but then without an error or so, my machine reboots suddenly!
 > I have an athlonxp 2000+ with kt333!
 > were can I find infos whats going on in that moment!

After a few test runs, It shows that this crash appears under more ore 
less high load!
e.g. start of mozilla/konquerror, or compiling some sources!
I have deaktivated acpi/apm.
Its like somebody pushes the reset buttom!

/var/log/messages shows this:
Jul 28 14:38:25 astacus kernel: kjournald starting.  Commit interval 5 
seconds
Jul 28 14:38:25 astacus kernel: EXT3 FS on hdb3, internal journal
Jul 28 14:38:25 astacus kernel: EXT3-fs: mounted filesystem with ordered 
data mode.
Jul 28 14:38:25 astacus kernel: eth0: Setting half-duplex based on 
auto-negotiated partner ability 0000.
Jul 28 14:38:26 astacus sshd[304]: Server listening on 0.0.0.0 port 22.
Jul 28 14:46:39 astacus syslogd 1.4.1: restart.

thats my system :
lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
KT266/A/333 AGP]
00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 08)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23)
01:00.0 VGA compatible controller: nVidia Corporation NV11DDR [GeForce2 
MX 100 DDR/200 DDR] (rev b2)

thanks in advance for any help!

- thorsten


