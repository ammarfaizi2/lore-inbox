Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131161AbQKWXtu>; Thu, 23 Nov 2000 18:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131226AbQKWXtk>; Thu, 23 Nov 2000 18:49:40 -0500
Received: from paloma12.e0k.nbg-hannover.de ([62.159.219.12]:49823 "HELO
        paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
        id <S131161AbQKWXtg>; Thu, 23 Nov 2000 18:49:36 -0500
From: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
Organization: DN
Date: Fri, 24 Nov 2000 00:20:29 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="iso-8859-1"
To: "Linux Kernel List" <linux-kernel@vger.kernel.org>
Subject: 2.4.0-test11: unresolved symbols
MIME-Version: 1.0
Message-Id: <00112400202900.00622@SunWave1>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I played around with the 'new' masquerading/network stuff for the first time. 
xDSL is coming to me in some days...:-)

I get the following unresolved symbols with pure 2.4.0-test11.
Am I missing something?

depmod: *** Unresolved symbols in 
/lib/modules/2.4.0-test11/kernel/net/ipv4/netfilter/ip_conntrack.o
depmod:          nf_unregister_hook
depmod:          nf_unregister_sockopt
depmod:          nf_register_hook
depmod:          nf_register_sockopt

depmod: *** Unresolved symbols in 
/lib/modules/2.4.0-test11/kernel/net/ipv4/netfilter/ip_tables.o
depmod:          nf_unregister_sockopt
depmod:          nf_register_sockopt

depmod: *** Unresolved symbols in 
/lib/modules/2.4.0-test11/kernel/net/ipv4/netfilter/iptable_filter.o
depmod:          nf_unregister_hook
depmod:          nf_register_hook

depmod: *** Unresolved symbols in 
/lib/modules/2.4.0-test11/kernel/net/ipv4/netfilter/iptable_nat.o
depmod:          nf_unregister_hook
depmod:          nf_register_hook

depmod: *** Unresolved symbols in 
/lib/modules/2.4.0-test11/kernel/net/ipv6/ipv6.o
depmod:          rtnetlink_links
depmod:          sk_run_filter
depmod:          nf_hooks
depmod:          __rta_fill
depmod:          netlink_set_err
depmod:          nf_setsockopt
depmod:          netlink_broadcast
depmod:          rtnetlink_put_metrics
depmod:          nf_getsockopt
depmod:          netlink_unicast
depmod:          rtnl
depmod:          nf_hook_slow

depmod: *** Unresolved symbols in 
/lib/modules/2.4.0-test11/kernel/net/ipv6/netfilter/ip6_tables.o
depmod:          nf_unregister_sockopt
depmod:          nf_register_sockopt

depmod: *** Unresolved symbols in 
/lib/modules/2.4.0-test11/kernel/net/ipv6/netfilter/ip6table_filter.o
depmod:          nf_unregister_hook
depmod:          nf_register_hook

depmod: *** Unresolved symbols in 
/lib/modules/2.4.0-test11/kernel/net/packet/af_packet.o
depmod:          sk_run_filter

Thanks,
         Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
Cognitive Systems Group
Vogt-Kölln-Straße 30
D-22527 Hamburg, Germany

email: nuetzel@kogs.informatik.uni-hamburg.de
@home: Dieter.Nuetzel@hamburg.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
