Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130010AbQLPF1r>; Sat, 16 Dec 2000 00:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129455AbQLPF12>; Sat, 16 Dec 2000 00:27:28 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:58111 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129183AbQLPF1W>; Sat, 16 Dec 2000 00:27:22 -0500
Message-ID: <3A3AF5F5.BDC853F4@haque.net>
Date: Fri, 15 Dec 2000 23:56:21 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: test13pre2 - netfilter modiles compile failure
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ld -m elf_i386 -r -o ip_nf_compat.o ipfwadm_core.o ip_fw_compat.o
ip_fw_compat_redir.o ip_fw_compat_masq.o ip_conntrack_standalone.o
ip_conntrack_core.o ip_conntrack_proto_generic.o
ip_conntrack_proto_tcp.o ip_conntrack_proto_udp.o
ip_conntrack_proto_icmp.o ip_nat_standalone.o ip_nat_rule.o
ip_nat_core.o ip_nat_proto_unknown.o ip_nat_proto_tcp.o
ip_nat_proto_udp.o ip_nat_proto_icmp.o
ip_conntrack_standalone.o: In function `init_module':
ip_conntrack_standalone.o(.text+0x6a4): multiple definition of
`init_module'
ip_fw_compat.o(.text+0x3dc): first defined here
ip_conntrack_standalone.o: In function `cleanup_module':
ip_conntrack_standalone.o(.text+0x6b0): multiple definition of
`cleanup_module'
ip_fw_compat.o(.text+0x3e8): first defined here
ip_nat_standalone.o: In function `init_module':
ip_nat_standalone.o(.text+0x78c): multiple definition of `init_module'
ip_fw_compat.o(.text+0x3dc): first defined here
ip_nat_standalone.o: In function `cleanup_module':
ip_nat_standalone.o(.text+0x798): multiple definition of
`cleanup_module'
ip_fw_compat.o(.text+0x3e8): first defined here
make[2]: *** [ip_nf_compat.o] Error 1
make[2]: Leaving directory
`/usr/src/linux-2.4.0-test13/net/ipv4/netfilter'

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
