Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264712AbTE1MuX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 08:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264713AbTE1MuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 08:50:22 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:49577 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S264712AbTE1MuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 08:50:18 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.21-rc4
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 28 May 2003 01:42:02 +0200
Message-ID: <m3brxokldh.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiled with RH 3.2.2 gcc - could I help by providing patches?

intrepid:/usr/src/linux-2.4$ make bzImage modules
md5sum: WARNING: 1 of 13 computed checksums did NOT match
sm_osl.c: In function `sm_osl_suspend':
sm_osl.c:671: warning: unused variable `wakeup_address'
generic.h:138: warning: `unknown_chipset' defined but not used
make[3]: Circular /usr/src/linux-2.4/include/linux/netfilter_ipv4/ip_conntrack_helper.h <- /usr/src/linux-2.4/include/linux/netfilter_ipv4/ip_conntrack.h dependency dropped.
ip_nat_helper.c: In function `ip_nat_resize_packet':
ip_nat_helper.c:87: warning: unused variable `data'
ip_nat_helper.c: In function `ip_nat_helper_register':
ip_nat_helper.c:493: warning: concatenation of string literals with __FUNCTION__ is deprecated
ip_nat_helper.c: In function `ip_nat_helper_unregister':
ip_nat_helper.c:577: warning: concatenation of string literals with __FUNCTION__ is deprecated
time.c:433: warning: `do_gettimeoffset_cyclone' defined but not used
dmi_scan.c: In function `dmi_decode':
dmi_scan.c:832: warning: unused variable `data'
agpgart_be.c: In function `agp_generic_create_gatt_table':
agpgart_be.c:580: warning: assignment from incompatible pointer type
balloc.c: In function `ext2_new_block':
balloc.c:524: warning: long unsigned int format, int arg (arg 4)
-- 
Krzysztof Halasa
Network Administrator
