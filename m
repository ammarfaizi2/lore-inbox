Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132570AbRDHQdn>; Sun, 8 Apr 2001 12:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132571AbRDHQdd>; Sun, 8 Apr 2001 12:33:33 -0400
Received: from usw-sf-sshgate.sourceforge.net ([216.136.171.253]:11252 "EHLO
	usw-sf-netmisc.sourceforge.net") by vger.kernel.org with ESMTP
	id <S132570AbRDHQdZ>; Sun, 8 Apr 2001 12:33:25 -0400
To: linux-kernel@vger.kernel.org
Subject: kgdb for 2.4.3 kernels
Message-Id: <E14mI7w-0007T7-00@usw-pr-shell1.sourceforge.net>
From: "Amit S. Kale" <akale@users.sourceforge.net>
Date: Sun, 08 Apr 2001 09:33:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

OOPS! I sent a wrong mail earlier under the same subject.

Linux kernel source level debugger, kgdb for linux kernel 2.4.3
is available from http://kgdb.sourceforge.net/

This version has following improvements over kgdb for 2.4.2 kernels:
1. Changed #ifdef __SMP__ statements to #ifdef CONFIG_SMP. 
2. Removed EXTRAVERSION=-kgdb line from the Makefile. This had
caused change in the name of the kernel. It was inconvenient in some
setups. If name of the kernel was already changed, the patch would fail
at this line.

Regards.
--
Amit S. Kale
<akale@users.sourceforge.net>
Linux kernel source level debugger    http://kgdb.sourceforge.net/
Translation filesystem                http://trfs.sourceforge.net/
