Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbUCTPdW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 10:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbUCTPdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 10:33:22 -0500
Received: from viefep18-int.chello.at ([213.46.255.21]:48175 "EHLO
	viefep18-int.chello.at") by vger.kernel.org with ESMTP
	id S263444AbUCTPdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 10:33:20 -0500
Message-ID: <405C653D.10008@freemail.hu>
Date: Sat, 20 Mar 2004 16:37:33 +0100
From: Janos Makadi <maki@freemail.hu>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Serial card
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a SWEEX i/o CARD, which has two serial, and one paralell ports. 
On the board is a Netmos (Moschip) Nm9835cv. Is it possible to use this 
card with the 2.6 series kernel? I`m searching on the net two days now, 
but didn`t found any information. Using setserial for setup failed.

lspci -v :

00:0b.0 Communication controller: Unknown device 9710:9835 (rev 01)
	Subsystem: LSI Logic / Symbios Logic (formerly NCR): Unknown device 0012
	Flags: medium devsel, IRQ 11
	I/O ports at b400 [disabled] [size=8]
	I/O ports at b000 [disabled] [size=8]
	I/O ports at a800 [disabled] [size=8]
	I/O ports at a400 [disabled] [size=8]
	I/O ports at a000 [disabled] [size=8]
	I/O ports at 9800 [disabled] [size=16]

/proc/pci :

Bus  0, device  11, function  0:
     Communication controller: NetMos Technology 222N-2 I/O Card (2S+1P) 
(rev 1).
       IRQ 11.
       Master Capable.  Latency=32.
       I/O at 0xb400 [0xb407].
       I/O at 0xb000 [0xb007].
       I/O at 0xa800 [0xa807].
       I/O at 0xa400 [0xa407].
       I/O at 0xa000 [0xa007].
       I/O at 0x9800 [0x980f].

Regards,
Janos
