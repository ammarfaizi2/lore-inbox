Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266216AbUHXOnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUHXOnd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 10:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267891AbUHXOnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 10:43:33 -0400
Received: from jade.spiritone.com ([216.99.193.136]:23965 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S266216AbUHXOna
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 10:43:30 -0400
Date: Tue, 24 Aug 2004 07:43:25 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc1 build failure (netfilter)
Message-ID: <31530000.1093358605@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net/built-in.o(.text+0x5c601): In function `tcp_in_window':
/usr/local/autobench/var/tmp/build/net/ipv4/netfilter/ip_conntrack_proto_tcp.c:682: undefined reference to `ip_ct_log_invalid'
net/built-in.o(.text+0x5c7c1): In function `tcp_error':
/usr/local/autobench/var/tmp/build/net/ipv4/netfilter/ip_conntrack_proto_tcp.c:783: undefined reference to `ip_ct_log_invalid'
net/built-in.o(.text+0x5c806):/usr/local/autobench/var/tmp/build/net/ipv4/netfilter/ip_conntrack_proto_tcp.c:791: undefined reference to `ip_ct_log_invalid'
net/built-in.o(.text+0x5c8a1):/usr/local/autobench/var/tmp/build/net/ipv4/netfilter/ip_conntrack_proto_tcp.c:807: undefined reference to `ip_ct_log_invalid'
net/built-in.o(.text+0x5c8d3):/usr/local/autobench/var/tmp/build/net/ipv4/netfilter/ip_conntrack_proto_tcp.c:816: undefined reference to `ip_ct_log_invalid'
net/built-in.o(.text+0x5ca6f):/usr/local/autobench/var/tmp/build/net/ipv4/netfilter/ip_conntrack_proto_tcp.c:863: more undefined references to `ip_ct_log_invalid' follow
make: *** [.tmp_vmlinux1] Error 1
