Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSK0FDV>; Wed, 27 Nov 2002 00:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261587AbSK0FDU>; Wed, 27 Nov 2002 00:03:20 -0500
Received: from zok.SGI.COM ([204.94.215.101]:8656 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S261582AbSK0FDU>;
	Wed, 27 Nov 2002 00:03:20 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-rc4 netfilter_ipv4 circular dependency
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 27 Nov 2002 16:10:21 +1100
Message-ID: <8832.1038373821@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Warning on build of 2.4.20-rc4.

Circular include/linux/netfilter_ipv4/ip_conntrack_helper.h <-
include/linux/netfilter_ipv4/ip_conntrack.h dependency dropped

CONFIG_NET=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
CONFIG_INET=y

