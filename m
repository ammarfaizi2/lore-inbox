Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965248AbVKPF6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248AbVKPF6y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 00:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965245AbVKPF6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 00:58:54 -0500
Received: from femail.waymark.net ([206.176.148.84]:22999 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S965248AbVKPF6x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 00:58:53 -0500
Date: 16 Nov 2005 02:03:50 GMT
From: Kenneth Parrish <Kenneth.Parrish@familynet-international.net>
Subject: Re: [2.6 patch] i386: always use 4k stacks
To: linux-kernel@vger.kernel.org
Message-ID: <303ad3.6fa079@familynet-international.net>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-=> In article 15 Nov 05  15:00:28, Adrian Bunk wrote to All <=-

[...]
 AB> Unconditionally enabling 4k stacks is the only way to achieve
 AB> this.
:) 2K might do here..

5 Tue Nov 15 19:29:43 ~/build/kernel/linux-2.6.15-rc1-git3 $ make checkstack
objdump -d vmlinux $(find . -name '*.ko') | \
perl /home/ken/build/kernel/linux-2.6.15-rc1-git3/scripts/checkstack.pl i386
0xc02bd528 huft_build:                                  1432
0xc02bd954 huft_build:                                  1432
0xc02be1c4 inflate_dynamic:                             1312
0xc02be2ff inflate_dynamic:                             1312
0xc02be082 inflate_fixed:                               1168
0xc02be172 inflate_fixed:                               1168
0x0000d748 ipv6_setsockopt:                             604
0x0000d788 ipv6_setsockopt:                             604
0xc0182a38 semctl_main:                                 588
0xc0182b11 semctl_main:                                 588
0xc022e938 ip_setsockopt:                               548
0xc022e9eb ip_setsockopt:                               548
0xc01831d4 sys_semtimedop:                              460
0xc01832d7 sys_semtimedop:                              460
0xc022f31d ip_getsockopt:                               436
0xc022f3b7 ip_getsockopt:                               436
0xc01b98de extract_buf:                                 424
0xc01b9818 extract_buf:                                 420
0xc0158ee4 sys_pivot_root:                              412
0xc0158f06 sys_pivot_root:                              412
0x0000e1a6 ipv6_getsockopt:                             392
0x0000e1e0 ipv6_getsockopt:                             392

... SPF  - Sender Policy Framework   [Electronic Mail]
--- MultiMail/Linux  Cyrix MII  1999 e-machines @ 200 MHz
