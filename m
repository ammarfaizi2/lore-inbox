Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUB1RyA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 12:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbUB1RyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 12:54:00 -0500
Received: from mout2.freenet.de ([194.97.50.155]:20391 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S261885AbUB1Rx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 12:53:59 -0500
Message-ID: <4040D68C.10004@gmx.net>
Date: Sat, 28 Feb 2004 18:57:32 +0100
From: Otto Meier <gf435@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031028 Thunderbird/0.4a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: GigaBit Netdriver instability
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I try to run a Dlink DGE-550T 64bit PCI Gigabit Card
with the driver dl2k and kernel 2.6.3-mm4. on a dual
athlon-MP MSI 6501 board.

With some heavier load on the net (transfering 2 1-Gbyte files to 2 
different clients on the net
2 100Mbit connections)

I get following messages in syslog

APIC error on CPU0: 02(02)
Feb 28 16:23:33 gate2 kernel: APIC error on CPU1: 02(02)
Feb 28 16:23:38 gate2 kernel: eth0: Transmit error, TxStatus 400270f, 
FrameId 67108864

after some several of these messages the network connection stops.

ifconfig eth0 down
unloading dl2k
und bringing the network up again it work again
until some higher traffic happens.


