Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbWFIAlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbWFIAlk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 20:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWFIAlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 20:41:40 -0400
Received: from athena.hosts.co.uk ([212.84.175.19]:61605 "EHLO
	athena.hosts.co.uk") by vger.kernel.org with ESMTP id S965055AbWFIAlj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 20:41:39 -0400
To: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
From: =?utf-8?q?=22Felix=20Oxley=22?= <lkml@oxley.org>
Reply-To: =?utf-8?q?=22Felix=20Oxley=22?= <lkml@oxley.org>
Subject: =?utf-8?q?2=2e6=2e17=2drc6=2dmm1=3a=20Signal=5f32=2ec=20won=27t=20compile=20on=20PowerBook?=
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <E1FoUtA-0006ci-KQ@artemis.hosts.co.uk>
Date: Fri, 09 Jun 2006 01:30:12 +0100
X-Spam-Score: -4.4 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suse 10.1.
PowerBook
make allnoconfig

  CC      arch/powerpc/kernel/syscalls.o
  CC      arch/powerpc/kernel/irq.o
  CC      arch/powerpc/kernel/align.o
  CC      arch/powerpc/kernel/signal_32.o
arch/powerpc/kernel/signal_32.c: In function ‘handle_rt_signal’:
arch/powerpc/kernel/signal_32.c:763: error: request for member ‘vdso_base’
in something not a structure or union
arch/powerpc/kernel/signal_32.c:766: error: request for member ‘vdso_base’
in something not a structure or union
arch/powerpc/kernel/signal_32.c: In function ‘handle_signal’:
arch/powerpc/kernel/signal_32.c:1037: error: request for member ‘vdso_base’
in something not a structure or union
arch/powerpc/kernel/signal_32.c:1040: error: request for member ‘vdso_base’
in something not a structure or union
make[1]: *** [arch/powerpc/kernel/signal_32.o] Error 1
make: *** [arch/powerpc/kernel] Error 2

I'll be happy to test fixes for anybody :-)
//felix
