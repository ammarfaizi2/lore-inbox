Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbRFTNlU>; Wed, 20 Jun 2001 09:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbRFTNlK>; Wed, 20 Jun 2001 09:41:10 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:10506 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S264876AbRFTNkz>; Wed, 20 Jun 2001 09:40:55 -0400
Date: Wed, 20 Jun 2001 15:36:51 +0200
From: Soeren Sonnenburg <sonnenburg@informatik.hu-berlin.de>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at inode.c:486 - where fixed ?
Message-ID: <20010620153651.B29711@server.intranet.wo.rk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Has this bug been fixed and if so in which version ?

Jun 20 00:15:14 zapp kernel: kernel BUG at inode.c:486!
Jun 20 00:15:14 zapp kernel: invalid operand: 0000
Jun 20 00:15:14 zapp kernel: CPU:    0
Jun 20 00:15:14 zapp kernel: EIP:    0010:[clear_inode+51/256]
Jun 20 00:15:14 zapp kernel: EFLAGS: 00010286
Jun 20 00:15:14 zapp kernel: eax: 0000001b   ebx: e4442ac0   ecx: e3488000   edx: e8a61540
Jun 20 00:15:14 zapp kernel: esi: c0263300   edi: e813a2c0   ebp: e3489fa4   esp: e3489edc
Jun 20 00:15:14 zapp kernel: ds: 0018   es: 0018   ss: 0018
Jun 20 00:15:14 zapp kernel: Process kpsewhich (pid: 28368, stackpage=e3489000)
Jun 20 00:15:14 zapp kernel: Stack: c021bc2e c021bc8d 000001e6 e4442ac0 c0140aa7 e4442ac0 e43cb140 e4442ac0
Jun 20 00:15:14 zapp kernel:        c0155fad e4442ac0 c013e516 e43cb140 e4442ac0 e43cb140 00000000 c0136f08
Jun 20 00:15:14 zapp kernel:        e43cb140 e3489f58 c013764a e813a2c0 e3489f58 00000000 efc58000 00000000
Jun 20 00:15:14 zapp kernel: Call Trace: [iput+311/336] [nfs_dentry_iput+29/48] [dput+214/336] [cached_lookup+72/96] [path_walk+1338/1936] [getname+90/Jun 20 00:15:14 zapp kernel:        [sys_access+141/304] [system_call+51/56]

Soeren.
