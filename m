Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268913AbTBSOOx>; Wed, 19 Feb 2003 09:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268912AbTBSOOx>; Wed, 19 Feb 2003 09:14:53 -0500
Received: from [213.151.209.11] ([213.151.209.11]:33428 "EHLO ns.isdd.sk")
	by vger.kernel.org with ESMTP id <S268910AbTBSOOw>;
	Wed, 19 Feb 2003 09:14:52 -0500
Date: Wed, 19 Feb 2003 15:26:03 +0100
From: "m." <michal017@centrum.sk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.19 & 2.4.20 unresolved symbols problem
Message-Id: <20030219152603.1e0a75a6.michal017@centrum.sk>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: "7G@=HHlcOkKWZV<cSewsGaS*#SBut}LoqAyp$62lJCCTqP0O$L}3}wCawPrDNJm~yvwO&<yD*5
 %JNxYJ|yq20:It~!Owg.wy\]Nud`{o#\MP/ol'&2M)\3/d<!\xMok:*d2^RGVHJ@knU*jg@Rdse
 <+6>FPLL[t]}0<n+am^H>}'H7Z]q%C-NluRPzo!|l,v$7,LU_$hsWoUM2_V!BFF8dBIV
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi.. I have problem building 2.4.19 and 2.4.20 kernel on my Linux
machine.. I'm using gcc 3.2.2 to build this kernel.
My commands are:
make xconfig
make dep
make bzImage
make modules
make modules_install

The last step fails with unresolved symbols in modules, such as:

depmod: *** Unresolved symbols in
/lib/modules/2.4.19/kernel/drivers/net/8139too.o depmod:        
__ioremap_R9eac042a depmod:         cpu_raise_softirq_Rd01f3ee8
depmod:         eth_type_trans_R81d268af
depmod:         __get_user_4
depmod:         netif_rx_R367bbba8
depmod:         __out_of_line_bug_R8b0fd3c5
depmod:         __const_udelay_Reae3dfd6
depmod:         skb_over_panic_R940e064f
depmod:         softnet_data_Re3822906

I did see some posts in this maillist but only when building 2.5 kernel,
not 2.4..
Can you suggest a solution?
Thanks..
michal
