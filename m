Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbUDPNTi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 09:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263165AbUDPNTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 09:19:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41869 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263163AbUDPNTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 09:19:36 -0400
Date: Fri, 16 Apr 2004 15:19:35 +0200
From: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: /dev/parport0 99,0 raw parport access
Message-ID: <20040416131935.GC6879@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

How do I cause linux to show 99,0 device (/dev/parport0, having devfs)?

I tried to display help for
make menuconfig -> Device Drivers -> Character devices -> Parallel
printer support
and
make menuconfig -> Device Drivers -> Character devices -> Support for
user-space parallel port device drivers

and the < Help > is not working.

I have enabled my parport in BIOS, enabled
make menuconfig -> Device Drivers -> Parallel port support -> Parallel
port support
and
make menuconfig -> Device Drivers -> Parallel port support -> PC-style
hardware
and my dmesg says:
parport0: PC-style at 0x378 [PCSPP(,...)]

However no /dev/parport0 is present.

I also consulted /usr/src/linux/Documentation/devices.txt which says
99 char        Raw parallel ports
                 0 = /dev/parport0     First parallel port
                 1 = /dev/parport1     Second parallel port
However this says nothing about what line should be ticked up in make
menuconfig to make these "raw parallel ports" work.

Cl<

