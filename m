Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVAWBk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVAWBk0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 20:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVAWBk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 20:40:26 -0500
Received: from brn35.neoplus.adsl.tpnet.pl ([83.29.107.35]:14129 "EHLO
	thinkpaddie") by vger.kernel.org with ESMTP id S261176AbVAWBkV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 20:40:21 -0500
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
Organization: K4
To: lkml <linux-kernel@vger.kernel.org>
Subject: can't compile 2.6.11-rc2 on sparc64
Date: Sun, 23 Jan 2005 02:38:54 +0100
User-Agent: KMail/1.7.91
X-Face: ?m}EMc-C]"l7<^`)a1NYO-(=?utf-8?q?=27xy3=3A5V=7B82Z=5E-/D3=5E=5BMU8IHkf=24o=60=7E=25CC5D4=5BGhaIgk?=
 =?utf-8?q?/=24oN7=0A=09Y7=3Bf=7D!?=(<IG>ooAGiKCVs$m~P1B-8Vt=]<V,FX{h4@fK/?Qtg]5ofD|P~&)q:6H>
 =?utf-8?q?=7E1Nt2fh=0A=09s-iKbN=24=2ENe=5E1?=(4tdwmmW>ew'=LPv+{{=YE=LoZU-5kfYnZSa`P7Q4pW]tKmUk`@&}M,
 =?utf-8?q?dn-=0A=09Kh=7BhA=7B=7ELs4a=24NjJI?=@1_f')]3|_}!GoJZss[Q$D-#l^.4GxPp[p:s<S~B&+6)
gj-laptop: yes
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501230238.55584@gj-laptop>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this error :
 
 CC      arch/sparc64/kernel/ioctl32.o
include/asm/uaccess.h: In function `siocdevprivate_ioctl':
fs/compat_ioctl.c:648: warning: ignoring return value of `copy_to_user', 
declared with attribute warn_unused_result
fs/compat_ioctl.c: In function `put_dirent32':
fs/compat_ioctl.c:2346: warning: ignoring return value of `copy_to_user', 
declared with attribute warn_unused_result
fs/compat_ioctl.c: In function `serial_struct_ioctl':
fs/compat_ioctl.c:2489: warning: ignoring return value of `copy_from_user', 
declared with attribute warn_unused_result
fs/compat_ioctl.c:2502: warning: ignoring return value of `copy_to_user', 
declared with attribute warn_unused_result
make[1]: *** [arch/sparc64/kernel/ioctl32.o] Error 1


gcc is 3.4, 64bit. That's ultra5.

-- 
GJ
