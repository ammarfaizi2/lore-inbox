Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266507AbRGLSyS>; Thu, 12 Jul 2001 14:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266530AbRGLSyQ>; Thu, 12 Jul 2001 14:54:16 -0400
Received: from ma-northadams1a-359.bur.adelphia.net ([24.52.175.103]:6660 "EHLO
	ma-northadams1a-359.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S266507AbRGLSwm>; Thu, 12 Jul 2001 14:52:42 -0400
Date: Thu, 12 Jul 2001 14:53:11 -0400
From: Eric Buddington <eric@ma-northadams1a-359.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.6: BUG at sched.c:709
Message-ID: <20010712145311.A11888@ma-northadams1a-359.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When booting 2.4.6 on my K62 with ALI chipset, I get the following:

ACPI: Core Subsystem version [20010615]
Scheduling in interrupt
kernel BUG at sched.c:709!
invalid operand: 0000
...
Process swapper (pid:1, stackpage=c1219000)

This is repeatable. I know you may want a ksymoops dump, but I'll only
do that on request, since I don't want to waste my time copying it if
this is an already-fixed bug. Let me know.

-Eric

P.S. This bug brought to you courtesy of serial console support -
Thanks to whoever got that working.
