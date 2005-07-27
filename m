Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVG0M42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVG0M42 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 08:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVG0M42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 08:56:28 -0400
Received: from mail.portrix.net ([212.202.157.208]:33982 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S262230AbVG0M41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 08:56:27 -0400
Message-ID: <42E78474.8070300@ppp0.net>
Date: Wed, 27 Jul 2005 14:56:20 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: miles@gnu.org
CC: linux-kernel@vger.kernel.org
Subject: v850, which gcc and binutils version?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles, my autobuilder picked up the defconfigs in 2.6.13-rc3-mm2 for
v850 but my toolchain (binutils I expect) seems to be wrong:

  AS      arch/v850/kernel/intv.o
/usr/src/ctest/mm/kernel/arch/v850/kernel/intv.S: Assembler messages:
/usr/src/ctest/mm/kernel/arch/v850/kernel/intv.S:36: Error: mov hilo(_start),r1: immediate operand is too large
/usr/src/ctest/mm/kernel/arch/v850/kernel/intv.S:43: Error: mov hilo(nmi),sp: immediate operand is too large
/usr/src/ctest/mm/kernel/arch/v850/kernel/intv.S:45: Error: mov hilo(nmi),sp: immediate operand is too large
/usr/src/ctest/mm/kernel/arch/v850/kernel/intv.S:47: Error: mov hilo(nmi),sp: immediate operand is too large
/usr/src/ctest/mm/kernel/arch/v850/kernel/intv.S:50: Error: mov hilo(trap),sp: immediate operand is too large
/usr/src/ctest/mm/kernel/arch/v850/kernel/intv.S:52: Error: mov hilo(trap),sp: immediate operand is too large
/usr/src/ctest/mm/kernel/arch/v850/kernel/intv.S:55: Error: mov hilo(dbtrap),sp: immediate operand is too large
/usr/src/ctest/mm/kernel/arch/v850/kernel/intv.S:85: Error: mov hilo(irq),sp: immediate operand is too large
/usr/src/ctest/mm/kernel/arch/v850/kernel/intv.S:85: Error: mov hilo(irq),sp: immediate operand is too large
/usr/src/ctest/mm/kernel/arch/v850/kernel/intv.S:85: Error: mov hilo(irq),sp: immediate operand is too large
/usr/src/ctest/mm/kernel/arch/v850/kernel/intv.S:85: Error: mov hilo(irq),sp: immediate operand is too large
/usr/src/ctest/mm/kernel/arch/v850/kernel/intv.S:85: Error: mov hilo(irq),sp: immediate operand is too large
/usr/src/ctest/mm/kernel/arch/v850/kernel/intv.S:85: Error: mov hilo(irq),sp: immediate operand is too large
make[2]: *** [arch/v850/kernel/intv.o] Error 1
make[1]: *** [arch/v850/kernel] Error 2
make: *** [_all] Error 2

gcc version 3.4.4 20050513 (prerelease)
GNU ld version 2.15.94.0.2.2 20041220

Full log at http://l4x.org/k/?d=5658

Which is the recommended gcc/binutils combination for v850?

Thanks,

-- 
Jan
