Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbUKCNoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbUKCNoS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 08:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbUKCNoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 08:44:18 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:49602 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261595AbUKCNoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 08:44:13 -0500
From: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Organization: -ENOENT
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
Date: Wed, 3 Nov 2004 14:44:10 +0100
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20041018145008.GA25707@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu>
In-Reply-To: <20041103105840.GA3992@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411031444.10570.l_allegrucci@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 11:58, Ingo Molnar wrote:
> 
> i have released the -V0.7.1 Real-Time Preemption patch, which can be
> downloaded from:
> 
>     http://redhat.com/~mingo/realtime-preempt/
> 
> this release is mainly a merge of -V0.6.9 to 2.6.10-rc2-mm2.

  AS      arch/i386/lib/checksum.o
  CC      arch/i386/lib/dec_and_lock.o
  CC      arch/i386/lib/delay.o
  AS      arch/i386/lib/getuser.o
  CC      arch/i386/lib/memcpy.o
  CC      arch/i386/lib/mmx.o
  CC      arch/i386/lib/strstr.o
  CC      arch/i386/lib/usercopy.o
  AR      arch/i386/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/mounts.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
net/built-in.o(.text+0x1887f): In function `netpoll_setup':
: undefined reference to `rcu_read_lock_up_read'
net/built-in.o(.text+0x188ed): In function `netpoll_setup':
: undefined reference to `rcu_read_lock_up_read'
make: *** [.tmp_vmlinux1] Error 1

CONFIG_NETPOLL=y
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y

-- 
I route therefore you are
