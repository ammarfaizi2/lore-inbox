Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284587AbRLETSQ>; Wed, 5 Dec 2001 14:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284576AbRLETSJ>; Wed, 5 Dec 2001 14:18:09 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:50420 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S284588AbRLETRj>; Wed, 5 Dec 2001 14:17:39 -0500
Subject: compile fails on 2.4.17-pre3
From: Paul Larson <plars@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 05 Dec 2001 13:23:14 +0000
Message-Id: <1007558606.14970.11.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is everybody seeing this and it's obvious, or do I need to send my
.config?

ld -m elf_i386  -r -o ipv4.o utils.o route.o inetpeer.o proc.o
protocol.o ip_input.o ip_fragment.o ip_forward.o ip_options.o
ip_output.o ip_sockglue.o tcp.o tcp_input.o tcp_output.o tcp_timer.o
tcp_ipv4.o tcp_minisocks.o tcp_diag.o raw.o udp.o arp.o icmp.o devinet.o
af_inet.o igmp.o sysctl_net_ipv4.o fib_frontend.o fib_semantics.o
fib_hash.o
ld: cannot open tcp_diag.o: No such file or directory
make[3]: *** [ipv4.o] Error 1
make[3]: Leaving directory `/usr/src/linux/net/ipv4'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/net/ipv4'
make[1]: *** [_subdir_ipv4] Error 2
make[1]: Leaving directory `/usr/src/linux/net'
make: *** [_dir_net] Error 2

