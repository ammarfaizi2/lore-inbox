Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbSK0TDH>; Wed, 27 Nov 2002 14:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbSK0TDH>; Wed, 27 Nov 2002 14:03:07 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56843 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264688AbSK0TDG>; Wed, 27 Nov 2002 14:03:06 -0500
Date: Wed, 27 Nov 2002 14:09:12 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Tom Diehl <tdiehl@rogueind.com>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20 ACPI
In-Reply-To: <r1_Pine.LNX.4.44.0211251848000.8602-100000@tigger.rogueind.com>
Message-ID: <Pine.LNX.3.96.1021127140608.6232F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2002, Tom Diehl wrote:

> Is this the same problem that Intel L440GX Motherboards have. In order to get
> it to boot I need to compile a custom kernel with acpi enabled. I am told it
> is some kind of irq routing problem and only Intel can fix it with a BIOS update
> which they do seem interested in addressing. :-( Sure would be nice to be able
> to boot stock Red Hat kernels on this machine.

>From memory, if both ACPI and APM are enabled, the ACPI notices the APM
and doesn't enable (or partially disables). Have you tried booting a RH
kernel with "noapm" to see if ACPI is there and would work for you if APM
were not there?

Do note, I haven't gone back to look at the RH config, I will try it for
grins the next time I reboot.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

