Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267119AbSKSHGF>; Tue, 19 Nov 2002 02:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267129AbSKSHGB>; Tue, 19 Nov 2002 02:06:01 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:51181
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267119AbSKSHF7>; Tue, 19 Nov 2002 02:05:59 -0500
Date: Tue, 19 Nov 2002 02:15:55 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ian Morgan <imorgan@webcon.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH][2.4-AC] export smp_num_siblings
In-Reply-To: <Pine.LNX.4.44.0211181835470.6121-100000@light.webcon.net>
Message-ID: <Pine.LNX.4.44.0211190214260.1538-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Ian Morgan wrote:

> > > c0292e28 D smp_num_siblings
> > > 
> > > Any clues?
> > 
> > Is CONFIG_SMP set?
> 
> Yup.

Can you give this a try.

Index: linux-2.4.20-rc1-ac4/arch/i386/kernel/i386_ksyms.c
===================================================================
RCS file: /build/cvsroot/linux-2.4.20-rc1-ac4/arch/i386/kernel/i386_ksyms.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 i386_ksyms.c
--- linux-2.4.20-rc1-ac4/arch/i386/kernel/i386_ksyms.c	18 Nov 2002 01:39:49 -0000	1.1.1.1
+++ linux-2.4.20-rc1-ac4/arch/i386/kernel/i386_ksyms.c	19 Nov 2002 07:11:43 -0000
@@ -131,6 +131,7 @@
 EXPORT_SYMBOL(cpu_data);
 EXPORT_SYMBOL(kernel_flag_cacheline);
 EXPORT_SYMBOL(smp_num_cpus);
+EXPORT_SYMBOL(smp_num_siblings);
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL_NOVERS(__write_lock_failed);
 EXPORT_SYMBOL_NOVERS(__read_lock_failed);

-- 
function.linuxpower.ca

