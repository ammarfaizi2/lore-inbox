Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbVAUUr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbVAUUr7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 15:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVAUUoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 15:44:01 -0500
Received: from www.missl.cs.umd.edu ([128.8.126.38]:35087 "EHLO
	www.missl.cs.umd.edu") by vger.kernel.org with ESMTP
	id S262504AbVAUUmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 15:42:51 -0500
Date: Fri, 21 Jan 2005 16:11:36 -0500 (EST)
From: Adam Sulmicki <adam@cfar.umd.edu>
X-X-Sender: adam@www.missl.cs.umd.edu
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: compile error in linux-2.6.11-rc1 
Message-ID: <Pine.BSF.4.62.0501211607560.50515@www.missl.cs.umd.edu>
X-WEB: http://www.eax.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hello,
 	fyi

   CC      arch/i386/kernel/timers/timer_pit.o
   CC      arch/i386/kernel/timers/common.o
   LD      arch/i386/kernel/timers/built-in.o
   CC      arch/i386/kernel/reboot.o
   CC      arch/i386/kernel/mpparse.o
   CC      arch/i386/kernel/apic.o
   CC      arch/i386/kernel/nmi.o
arch/i386/kernel/nmi.c: In function `check_nmi_watchdog':
arch/i386/kernel/nmi.c:130: error: `cpu_callin_map' undeclared (first use 
in this function)
arch/i386/kernel/nmi.c:130: error: (Each undeclared identifier is reported 
only once
arch/i386/kernel/nmi.c:130: error: for each function it appears in.)
make[1]: *** [arch/i386/kernel/nmi.o] Error 1
make: *** [arch/i386/kernel] Error 2
linux:/usr/src/cm/kexec/linux-2.6.11-rc1 #

