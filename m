Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVATUAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVATUAz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 15:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVATUAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 15:00:55 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40858 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261937AbVATT7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:59:14 -0500
Date: Thu, 20 Jan 2005 15:58:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Jenkins <aj504@student.cs.york.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 suspend-to-disk bug (during resume)
Message-ID: <20050120145804.GJ476@openzaurus.ucw.cz>
References: <1106210882.7975.9.camel@linux.site> <1106210985l.8224l.0l@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106210985l.8224l.0l@linux>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 10 (level, low) -> IRQ 10
> bad: scheduling while atomic!
>  [<c030164e>] schedule+0x4be/0x570
>  [<c011ce69>] call_console_drivers+0x79/0x110
>  [<c0124817>] __mod_timer+0x177/0x190
>  [<c0301b8a>] schedule_timeout+0x5a/0xb0
>  [<c0293ed9>] 
Try without preempt for an ugly workaround. Also try to reproduce it
on 2.6.11-rc1.
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

