Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264960AbUGSKyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbUGSKyU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 06:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbUGSKyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 06:54:19 -0400
Received: from relay1.aspec.ru ([217.14.198.4]:11528 "EHLO mail.aspec.ru")
	by vger.kernel.org with ESMTP id S264960AbUGSKyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 06:54:17 -0400
Message-ID: <40FBA854.5050102@belkam.com>
Date: Mon, 19 Jul 2004 15:54:12 +0500
From: Dmitry Melekhov <dm@belkam.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.26, sundance, oops
References: <40FB9119.5030507@belkam.com>
In-Reply-To: <40FB9119.5030507@belkam.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

btw, I just got following:

NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, TxStatus 00 TxFrameId 1e, resetting...
00 0dbf2000 0dbf2010 00008001(00) 0dbad812 80000044
01 0dbf2010 0dbf2020 00008005(01) 0db9c012 80000044
02 0dbf2020 0dbf2030 00008009(02) 0a254012 80000044
03 0dbf2030 0dbf2040 0000800d(03) 0db7f812 80000044
04 0dbf2040 0dbf2050 00008011(04) 0d746012 80000044
05 0dbf2050 0dbf2060 00008015(05) 0db8b812 80000040
06 0dbf2060 0dbf2070 00008019(06) 0c8d0812 80000044
07 0dbf2070 0dbf2080 0000801d(07) 0df8fd92 8000006e
08 0dbf2080 0dbf2090 00008021(08) 0df8f392 8000006e
09 0dbf2090 0dbf20a0 00008025(09) 0a35e812 80000042
0a 0dbf20a0 0dbf20b0 00000029(0a) 0cbd0012 800005b1
0b 0dbf20b0 0dbf20c0 0000802d(0b) 09fea012 800005b1
0c 0dbf20c0 0dbf20d0 00008031(0c) 0db85812 800005b1
0d 0dbf20d0 0dbf20e0 00008035(0d) 0dbc8812 80000434
0e 0dbf20e0 0dbf20f0 00008039(0e) 0a76f012 80000036
0f 0dbf20f0 0dbf2100 0000803d(0f) 0dc39012 80000036
10 0dbf2100 0dbf2110 00008041(10) 0dfd0812 800000aa
11 0dbf2110 0dbf2120 00008045(11) 0a34f812 80000036
12 0dbf2120 0dbf2130 00008049(12) 0a875392 8000007e
13 0dbf2130 0dbf2140 0000804d(13) 0d923812 8000003e
14 0dbf2140 0dbf2150 00008051(14) 0a769012 80000036
15 0dbf2150 0dbf2160 00008055(15) 0a158812 800005b1
16 0dbf2160 0dbf2170 00008059(16) 0d98d012 800005b1
17 0dbf2170 0dbf2180 0000805d(17) 0a875a92 8000006e
18 0dbf2180 0dbf2190 00008061(18) 0a769812 800001fe
19 0dbf2190 0dbf21a0 00008065(19) 0ca0a812 80000036
1a 0dbf21a0 0dbf21b0 00008069(1a) 0a37f012 80000036
1b 0dbf21b0 00000000 0000806d(1b) 0a332012 80000036
1c 0dbf21c0 0dbf21d0 00008071(1c) 00000000 00000000
1d 0dbf21d0 0dbf21e0 00008075(1d) 00000000 00000000
1e 0dbf21e0 0dbf21f0 00008079(1e) 0db74012 800000a6
1f 0dbf21f0 0dbf2000 0000807d(1f) 0a757812 80000044
TxListPtr=6e726568 netif_queue_stopped=1
cur_tx=1149148(1c) dirty_tx=1149118(1e)
cur_rx=4 dirty_rx=4
cur_task=1149148


I run this card only for several days and looks like hardware or 
software is buggy :-(


