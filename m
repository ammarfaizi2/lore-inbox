Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315105AbSD2Lqm>; Mon, 29 Apr 2002 07:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315113AbSD2Lql>; Mon, 29 Apr 2002 07:46:41 -0400
Received: from emerald3.kumin.ne.jp ([210.132.100.202]:26829 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP
	id <S315111AbSD2LnQ>; Mon, 29 Apr 2002 07:43:16 -0400
Message-Id: <200204291142.AA00055@prism.kumin.ne.jp>
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
Date: Mon, 29 Apr 2002 20:42:46 +0900
To: linux-kernel@vger.kernel.org
Subject: linux-2.5.11 compile error ( without framebuffer )
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.12
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I compile linux-2.5.11 ( gcc-2.95.3 ), but compile error occured at framebuffer.
Then I recompile linux-2.5.11 without framebuffer, but compile error again.


ide.c: In function `reset_pollfunc':
ide.c:603: warning: assignment discards qualifiers from pointer target type
eepro100.c:2252: warning: `eepro100_remove_one' defined but not used
bluesmoke.c: In function `intel_thermal_interrupt':
bluesmoke.c:36: warning: implicit declaration of function `ack_APIC_irq'
bluesmoke.c: In function `intel_init_thermal':
bluesmoke.c:92: warning: implicit declaration of function `apic_read'
bluesmoke.c:104: warning: implicit declaration of function `apic_write_around'
arch/i386/kernel/kernel.o: In function `intel_thermal_interrupt':
arch/i386/kernel/kernel.o(.text+0x7221): undefined reference to `ack_APIC_irq'
arch/i386/kernel/kernel.o: In function `intel_init_thermal':
arch/i386/kernel/kernel.o(.text.init+0x2ad2): undefined reference to `apic_read'
arch/i386/kernel/kernel.o(.text.init+0x2b12): undefined reference to `apic_write_around'
arch/i386/kernel/kernel.o(.text.init+0x2b31): undefined reference to `apic_read'
arch/i386/kernel/kernel.o(.text.init+0x2b41): undefined reference to `apic_write_around'
make: *** [vmlinux] Error 1

--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
