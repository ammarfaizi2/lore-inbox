Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbUKPSBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUKPSBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 13:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbUKPSBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 13:01:12 -0500
Received: from fidel.freesurf.fr ([212.43.206.16]:62610 "EHLO
	fidel.freesurf.fr") by vger.kernel.org with ESMTP id S262078AbUKPSAQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 13:00:16 -0500
Message-ID: <29367.134.214.201.98.1100628015.squirrel@jose.freesurf.fr>
Date: Tue, 16 Nov 2004 19:00:15 +0100 (CET)
Subject: [bug]Broken driver for a SK nic
From: <tuxeed@freesurf.fr>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
X-Mailer: SquirrelMail (version 1.2.5)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I bought a new box with a 64bits proc (Athlon) 512Mo of RAM and so on
I use a 2.6.9rc1 (the most recent I found (in a mag) without ANY internet
connection)under sourcemage
So my nic is:

#dmesg | grep eth0
eth0: Yukon Gigabit Ethernet 10/10/1000Base-T Adaptater

I must use the sk98lin module which is integrated to the kernel well easy.
I recompile the kernel and I modprobe the module:

#modprobe sk98lin
ACPI: PCI interrupt 0000:02:00.0[A] ->GSI 11 (level, low) ->IRQ11
ACPI: PCI interrupt 0000:02:00.0[A] ->GSI 11 (level, low) ->IRQ11
eth0: --ERROR--
Class: internal software error
Nr: 0x1ae
Msg: General: Driver release date not initialized
eth0: --ERROR--
Class: internal software error
Nr: 0x1ae
Msg: General: Driver release date not initialized
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adaptater
         PrefPort:A  RlmtMode: check Link State
dhcpcd[2875]: dhcpStart: retrying MAC address request (returned
00:00:00:00:00:00)
eth0: network connection is up #là gros sourire :D
       speed:100
       autonegotiation: yes
       duplex mode: full
       flowctrl:symmetric
       irq moderation: disabled
       scatter-gather: enabled
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock write locked
I've got this and the pc freeze does anyone get a clue about what goes
wrong?
Thx


