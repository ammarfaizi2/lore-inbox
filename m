Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbTLKTFh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 14:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbTLKTFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 14:05:37 -0500
Received: from mail2.cc.huji.ac.il ([132.64.1.18]:63666 "EHLO
	mail2.cc.huji.ac.il") by vger.kernel.org with ESMTP id S265206AbTLKTFf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 14:05:35 -0500
Message-ID: <3FD8BFF3.9060508@mscc.huji.ac.il>
Date: Thu, 11 Dec 2003 21:05:23 +0200
From: Voicu Liviu <pacman@mscc.huji.ac.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031206
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: nVidia Corporation nForce2 AC97
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel:
---------
liviu@starshooter liviu $ uname -a
Linux starshooter 2.6.0-test11 #1 Wed Dec 10 22:57:58 IST 2003 i686
AMD Athlon(tm) XP 2600+ AuthenticAMD GNU/Linux
liviu@starshooter liviu $

I tryied to have alsa working and crashes all the time, xmms also at
the beginning of the song crashes...this is what the kernel show me at
dmesg:

intel8x0: clocking to 47461
irq 21: nobody cared!
Call Trace:
 [<c010b80a>] __report_bad_irq+0x2a/0x90
 [<c010b900>] note_interrupt+0x70/0xb0
 [<c010bbf0>] do_IRQ+0x130/0x140
 [<c0107030>] default_idle+0x0/0x30
 [<c0105000>] _stext+0x0/0x60
 [<c0109e08>] common_interrupt+0x18/0x20
 [<c0107030>] default_idle+0x0/0x30
 [<c0105000>] _stext+0x0/0x60
 [<c0107054>] default_idle+0x24/0x30
 [<c01070d0>] cpu_idle+0x30/0x40
 [<c037e70a>] start_kernel+0x17a/0x1b0
 [<c037e440>] unknown_bootoption+0x0/0x110

handlers:
[<e0c5b7f0>] (snd_intel8x0_interrupt+0x0/0x210 [snd_intel8x0])
Disabling IRQ #21


