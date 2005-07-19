Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVGSRmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVGSRmC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 13:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVGSRmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 13:42:02 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:20154 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261564AbVGSRmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 13:42:01 -0400
Date: Tue, 19 Jul 2005 19:41:57 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Piszcz, Justin" <jpiszcz@servervault.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Suddenly getting APIC errors on SMP system using 2.4.20-8smp,
 mobo dying?
In-Reply-To: <F8B974E70BDE1745ABB27AF04788FA0099883E@mail1.dulles.sv.int>
Message-ID: <Pine.LNX.4.61.0507191937410.89@yvahk01.tjqt.qr>
References: <F8B974E70BDE1745ABB27AF04788FA0099883E@mail1.dulles.sv.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>http://lkml.org/lkml/2003/5/18/64 (the problem we are having)

>on it's way out. Try running with 'noapic' to see if it's the IOAPIC or 
>local APICs (my bet is on the IOAPIC which would be on your motherboard 
>chipset)"

I have the same problem, throughout 2.6.11 to 2.6.13-rc1, maybe before.

It pops up when CONFIG_ACPI=y (CONFIG_X86_UP_APIC,IO_APIC or UP_IO_APIC does 
not affect this!) && when my ISDN card is active, e.g. I'm online. If it's not 
online, everything is fine.

APIC error on CPU0: 02(02)

This only shows if I run `klogconsole -l8`, which means this message is 
printed with KERN_DEBUG.
I do live on UP, though. Everytime I get this message, the ERR counter 
increases.

lspci:
0000:00:0a.0 Network controller: Tiger Jet Network Inc. Tiger3XX Modem/ISDN 
interface
Need more info?


Jan Engelhardt
-- 
