Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbTATKec>; Mon, 20 Jan 2003 05:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbTATKec>; Mon, 20 Jan 2003 05:34:32 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:47377 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261398AbTATKeb>; Mon, 20 Jan 2003 05:34:31 -0500
Message-Id: <200301201023.h0KAN8s06017@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: PCI wireless NIC: can't set MAC addr
Date: Mon, 20 Jan 2003 12:22:24 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel is 2.4.20-pre11.

I seem to be unable to set MAC address on a D-Link
DWL-520 (a PCI wireless NIC). I am using 2.4.20-pre11
and orinoco_pci as a module.

It seems to work and I can see my frames with correct
MAC address with tcpdump. The problem is, other hosts
do not like me anymore :( I see zero incoming packets.
This happens even if I set MAC addr before bringing
iface up. I.e. no host can possibly cache stale ARP
data...

I suspect either orinoco driver does not set MAC addr
properly or firmware has a bug. BTW, firmware version
is 1.4.9.

I'd be grateful if someone with any wireless card
will do a quick check with their hardware/firmware/driver
combo and tell me the results.
--
vda
