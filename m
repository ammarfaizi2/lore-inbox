Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266484AbUFWM5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266484AbUFWM5v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 08:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266471AbUFWM5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 08:57:50 -0400
Received: from clem.clem-digital.net ([68.16.168.10]:55817 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S266462AbUFWM4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 08:56:12 -0400
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200406231256.IAA28505@clem.clem-digital.net>
Subject: 2.6.7-bk6 fails module compile -- iptable_raw.c
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Wed, 23 Jun 2004 08:56:08 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:  (gcc version 2.95.4)

  CC [M]  net/ipv4/netfilter/iptable_raw.o
net/ipv4/netfilter/iptable_raw.c:57: unknown field `target_size' specified in initializer
net/ipv4/netfilter/iptable_raw.c:57: warning: missing braces around initializer
net/ipv4/netfilter/iptable_raw.c:57: warning: (near initialization for `initial_table.entries[0].target.target.u')
net/ipv4/netfilter/iptable_raw.c:71: unknown field `target_size' specified in initializer
net/ipv4/netfilter/iptable_raw.c:85: unknown field `user' specified in initializer
net/ipv4/netfilter/iptable_raw.c:87: unknown field `name' specified in initializer
net/ipv4/netfilter/iptable_raw.c:87: warning: excess elements in union initializer
net/ipv4/netfilter/iptable_raw.c:87: warning: (near initialization for `initial_table.term.target.target.u')
make[3]: *** [net/ipv4/netfilter/iptable_raw.o] Error 1
make[2]: *** [net/ipv4/netfilter] Error 2
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2

-- 
Pete Clements 
