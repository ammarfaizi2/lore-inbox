Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265043AbTFRBvy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 21:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265045AbTFRBvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 21:51:54 -0400
Received: from [203.94.130.164] ([203.94.130.164]:22457 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id S265043AbTFRBvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 21:51:53 -0400
Date: Wed, 18 Jun 2003 11:38:10 +1000 (EST)
From: Brett <generica@email.com>
X-X-Sender: brett@bad-sports.com
To: linux-kernel@vger.kernel.org
Subject: panic with 2.5.72 - i82365
Message-ID: <Pine.LNX.4.44.0306181135310.25169-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

I hope I copied down enough for this to be useful

Call Trace:
 [<c01c1e9b>] class_device_create_file+0x1b/0x20
 [<x02a51fe>] init_i82365+0xfe/0x1e0
 [<c029869b>] do_initcalls+0x2b/0xa0
 [<c0105090>] init+0x30/0x1b0
 [<c0105060>] init+0x0/0x1b0
 [<c0106fd9>] kernel_thread_helper+0x5/0xc

Code: 8b 43 08 8d 48 68 ff 48 68 0f 88 15 01 00 00 8b 37 56 53 e8
 <0>Kernel panic: Attempted to kill init!

Happens during boot with a p75 toshiba laptop

CONFIG_PCMCIA=y
CONFIG_I82365=y
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y

any extra info is of course available on request

thanks,

	/ Brett

