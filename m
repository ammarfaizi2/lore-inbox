Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUILVGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUILVGS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 17:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUILVGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 17:06:18 -0400
Received: from zork.zork.net ([64.81.246.102]:17057 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S262062AbUILVFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 17:05:53 -0400
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: jgarzik@pobox.com, akpm@osdl.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm4: r8169: irq 16: nobody cared!/TX Timeout
References: <6upt4s4cro.fsf@zork.zork.net>
	<20040912110614.GA20942@electric-eye.fr.zoreil.com>
	<6u8ybf2w3f.fsf@zork.zork.net>
	<20040912204319.GA27282@electric-eye.fr.zoreil.com>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Francois Romieu <romieu@fr.zoreil.com>, jgarzik@pobox.com,
	akpm@osdl.org, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Date: Sun, 12 Sep 2004 22:05:23 +0100
In-Reply-To: <20040912204319.GA27282@electric-eye.fr.zoreil.com> (Francois
	Romieu's message of "Sun, 12 Sep 2004 22:43:19 +0200")
Message-ID: <6uisaj19m4.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> writes:

> Sean Neakums <sneakums@zork.net> :
> [...]
>> Unfortunately after tonight I won't have access to this machine until
>> Friday evening.  I'll grab the netdev patchset and try those next.
>
> via686a based multiprocessor board and acpi...
>
> Can you try vanilla 2.6.8 r8169 driver with 2.6.9-rc1-mm4 ?

Same result on starting X:

irq 16: nobody cared!
 [__report_bad_irq+36/144] __report_bad_irq+0x24/0x90
 [note_interrupt+146/352] note_interrupt+0x92/0x160
 [do_IRQ+354/416] do_IRQ+0x162/0x1a0
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [default_idle+0/64] default_idle+0x0/0x40
 [default_idle+44/64] default_idle+0x2c/0x40
 [cpu_idle+52/80] cpu_idle+0x34/0x50
handlers:
[rtl8169_interrupt+0/272] (rtl8169_interrupt+0x0/0x110)
Disabling IRQ #16
