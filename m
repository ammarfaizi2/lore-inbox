Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263408AbTECTgz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 15:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263409AbTECTgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 15:36:55 -0400
Received: from mailout.mbnet.fi ([194.100.161.24]:10504 "EHLO posti.mbnet.fi")
	by vger.kernel.org with ESMTP id S263408AbTECTgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 15:36:54 -0400
Message-ID: <1649.194.100.165.159.1051991352.squirrel@webmail.mbnet.fi>
Date: Sat, 3 May 2003 22:49:12 +0300 (EEST)
Subject: [2.5.68-osdl2] hisax unknown symbols
From: Kmt Sundqvist <rabbit80@mbnet.fi>
To: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.5)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 03 May 2003 19:49:16.0551 (UTC) FILETIME=[14625970:01C311AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

2.5.68-osdl2, a HFC-PCI card, "modprobe hisax type=35" done

These are from kern.log, and this came at boot-time.  Is isdn4linux or
CAPI 2 working in 2.5.68?  Couldn't find anything about it in
http://www.codemonkey.org.uk/post-halloween-2.5.txt
May  3 14:53:50 kernel: isdn: Unknown symbol group_send_sig_info
May  3 14:53:50 kernel: hisax: Unknown symbol kstat__per_cpu
May  3 14:53:50 kernel: hisax: Unknown symbol register_isdn

modprobe gives the same results into kern.log

*** lspci ***

00:00.0 Host bridge: Intel Corp. 430HX - 82439HX TXC
[Triton II] (rev 01)
00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA
[Natoma/Triton II]
00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE
[Natoma/Triton II]
00:0b.0 Network controller: Asustek Computer, Inc.:
Unknown device 0675 (rev 02)
00:0d.0 VGA compatible controller: S3 Inc. 86c764/765
[Trio32/64/64V+]

-Kimmo Sundqvist


