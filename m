Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbUBWNL6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 08:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbUBWNL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 08:11:58 -0500
Received: from mail.brainsys.cz ([193.179.153.3]:44523 "EHLO mail.brainsys.cz")
	by vger.kernel.org with ESMTP id S261836AbUBWNLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 08:11:50 -0500
Message-ID: <4039FBE9.4050001@Kristof.CZ>
Date: Mon, 23 Feb 2004 14:11:05 +0100
From: =?UTF-8?B?S3JpxaF0b2YgUGV0cg==?= <Petr@kristof.cz>
Reply-To: Petr@kristof.cz
Organization: Another certified B.O.F.H.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: cs, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Call Trace: [<c010ca22>] __report_bad_irq+0x2a/0x8b
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Filter-Version: MailCorral Ver 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

from kernel 2.6.2rc1 about I getting this message and system lock
console from time to time. Standard HW, intel based PC.


irq 18: nobody cared!
Call Trace:
[<c010ca22>] __report_bad_irq+0x2a/0x8b
[<c010cb0c>] note_interrupt+0x6f/0x9f
[<c010cda1>] do_IRQ+0x11e/0x13d
[<c010b20c>] common_interrupt+0x18/0x20
[<c01086ae>] default_idle+0x0/0x2c
[<c01086d7>] default_idle+0x29/0x2c
[<c0108740>] cpu_idle+0x33/0x3c
[<c011fa28>] printk+0x169/0x19b

handlers:
[<c020f071>] (ide_intr+0x0/0x16b)
[<c020f071>] (ide_intr+0x0/0x16b)
[<f894cb8a>] (ata_interrupt+0x0/0x123 [libata])
Disabling IRQ #18

I reported it as
http://bugme.osdl.org/show_bug.cgi?id=2160

Petr


