Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbTCCKyD>; Mon, 3 Mar 2003 05:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264646AbTCCKyD>; Mon, 3 Mar 2003 05:54:03 -0500
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:49604 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S264628AbTCCKyC>; Mon, 3 Mar 2003 05:54:02 -0500
Date: Mon, 3 Mar 2003 11:07:37 +0000
From: roman duka <unixfreak@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM:
Message-Id: <20030303110737.45d91d6b.unixfreak@ntlworld.com>
X-Mailer: Sylpheed version 0.7.2claws (GTK+ 1.2.10; i686-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if i go to /usr/src/linux and edit Makefile and replace the line:

ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/)

with:

ARCH := arm

and then run 'make menuconfig' menuconfig goes into infinite loop and gets killed when it uses up all available memory. any ideas how to fix this problem??


roman@athlon1000: sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux athlon1000 2.4.20-IPSec #19 Fri Jan 24 17:57:03 GMT 2003 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.12
e2fsprogs              tune2fs
Linux C Library        x    1 root     root      1394238 Mar 23  2002 /lib/libc.so.6
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         sg loop parport_pc lp parport ipv6 ipt_MASQUERADE iptable_nat ipt_state ip_conntrack iptable_filter ip_tables sch_tbf tulip 8139too mii ide-scsi st rtc ide-cd sr_mod cdrom
roman@athlon1000: 

-- 
Roman Duka
75 Gipsy Lane
Oxford, OX3 7PU
Tel 07733406200
http://unixfreaks.no-ip.org
