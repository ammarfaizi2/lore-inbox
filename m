Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318079AbSHDDfm>; Sat, 3 Aug 2002 23:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318085AbSHDDfm>; Sat, 3 Aug 2002 23:35:42 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:56670 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S318079AbSHDDfl>;
	Sat, 3 Aug 2002 23:35:41 -0400
From: <Hell.Surfers@cwctv.net>
To: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Date: Sun, 4 Aug 2002 04:38:24 +0100
Subject: RE:2.4.19 warnings with allnoconfig
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1028432304582"
Message-ID: <0ab2d4837030482DTVMAIL12@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1028432304582
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

most of those arent really problems, justwasting space, functions defined but not called are not damaging, they might be there for later functionality, but doing that is annoying, and dirtys code, which gives me stress, ;) dm.



On 	Sun, 04 Aug 2002 13:23:52 +1000 	Keith Owens <kaos@ocs.com.au> wrote:

--1028432304582
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Sun, 4 Aug 2002 04:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318077AbSHDDUd>; Sat, 3 Aug 2002 23:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318079AbSHDDUd>; Sat, 3 Aug 2002 23:20:33 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:50183 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S318077AbSHDDUd>;
	Sat, 3 Aug 2002 23:20:33 -0400
Received: (qmail 11302 invoked from network); 4 Aug 2002 03:24:02 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 4 Aug 2002 03:24:02 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id BF7D13000B8; Sun,  4 Aug 2002 13:23:57 +1000 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP id 780F494
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2002 13:23:57 +1000 (EST)
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 warnings with allnoconfig
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Aug 2002 13:23:52 +1000
Message-ID: <23899.1028431432@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

2.4.19 with make allnoconfig produces these warnings.  How about
getting a clean kernel before starting on 2.4.20?

init/do_mounts.c:980: warning: `crd_load' defined but not used

arch/i386/kernel/setup.c: In function `amd_adv_spec_cache_feature': 
arch/i386/kernel/setup.c:751: warning: implicit declaration of function `have_cpuid_p'
arch/i386/kernel/setup.c: At top level:
arch/i386/kernel/setup.c:2629: warning: `have_cpuid_p' was declared implicitly `extern' and later `static'
arch/i386/kernel/setup.c:751: warning: previous declaration of `have_cpuid_p' 

arch/i386/kernel/dmi_scan.c:196: warning: `disable_ide_dma' defined but not used

fs/dnotify.c: In function `__inode_dir_notify':
fs/dnotify.c:139: warning: label `out' defined but not used

fs/namespace.c: In function `mnt_init':
fs/namespace.c:1093: warning: implicit declaration of function `init_rootfs'

drivers/char/random.c:540: warning: `free_entropy_store' defined but not used

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1028432304582--


