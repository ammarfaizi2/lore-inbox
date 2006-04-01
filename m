Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWDAKEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWDAKEq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 05:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWDAKEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 05:04:46 -0500
Received: from erik-slagter.demon.nl ([83.160.41.216]:9397 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S1751021AbWDAKEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 05:04:45 -0500
Subject: OOPS 2.6.16 and 2.6.16-git14
From: Erik Slagter <erik@slagter.name>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 01 Apr 2006 12:04:41 +0200
Message-Id: <1143885881.26249.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I get a kernel OOPS using 2.6.16 and 2.6.16-git14, I was using 2.6.14.2
> before without the problem.
> 
> The OOPS happens when doing either
> 
> echo "3" > /proc/acpi/sleep
> 
> or
> 
> echo "mem" > /sys/power/state
> 
> As I have a laptop without serial ports, I'd have to write down the
> oops, so please forgive that I didn't write down ALL the output, I think
> I have the most important stuff, though.
> 
> Please note that it also happens when mentioned modules are not linked
> in and that I enabled the kernel read-only pages option (although that
> doesn't seem to be related).
> 
> I am not subscribed, so please CC.

Currently I cannot reproduce this, this may have to do with:

 - moved pl2303 adapter from one usb2 hub to another because kernel
barfed about it and that solved the barfing
 - compiled various versions of the kernel so many times, I lost track
of the exact config
 - different usb hub and perifs at home and at work.

As soon as I can reproduce the issue, I'll file a proper bug report
including photographs of the output.

Thanks for your time and effort.
