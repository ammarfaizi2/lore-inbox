Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317753AbSGZOwW>; Fri, 26 Jul 2002 10:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317759AbSGZOwW>; Fri, 26 Jul 2002 10:52:22 -0400
Received: from web21102.mail.yahoo.com ([216.136.227.104]:22349 "HELO
	web21102.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317753AbSGZOwU>; Fri, 26 Jul 2002 10:52:20 -0400
Message-ID: <20020726145535.35705.qmail@web21102.mail.yahoo.com>
Date: Fri, 26 Jul 2002 15:55:35 +0100 (BST)
From: =?iso-8859-1?q?Steven=20Newbury?= <s_j_newbury@yahoo.co.uk>
Subject: bonding driver failure in 2.5
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since around version 2.5.20 bringing up my bond0 interface causes the system to
freeze, no oopses.  The last version I know for sure that it worked with is
2.5.18.

The bond0 interface bonds two ethernet interfaces,  both ports of the on-board
3c982 on my Tyan K7 Thunder mobo.

Here is my lscpi output:
00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-765 [Viper] ISA (rev 02)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-765 [Viper] IDE (rev
01)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-765 [Viper] ACPI (rev 01)
00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-765 [Viper] USB (rev
07)
00:09.0 Ethernet controller: Accton Technology Corporation: Unknown device 1216
(rev 11)
00:0a.0 Unknown mass storage controller: Promise Technology, Inc. 20262 (rev
01)
00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 08)
00:0b.1 Input device controller: Creative Labs SB Live! (rev 08)
00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:0d.0 SCSI storage controller: Adaptec 7899P (rev 01)
00:0d.1 SCSI storage controller: Adaptec 7899P (rev 01)
00:0e.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:0f.0 Ethernet controller: 3Com Corporation 3c982 Dual Port Server Cyclone
(rev 78)
00:10.0 Ethernet controller: 3Com Corporation 3c982 Dual Port Server Cyclone
(rev 78)
01:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)


=====
Steve

__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
