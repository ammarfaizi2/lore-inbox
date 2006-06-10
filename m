Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWFJMt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWFJMt4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 08:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWFJMtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 08:49:55 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:38410 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751507AbWFJMty convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 08:49:54 -0400
From: Felix Oxley <felix@oxley.org>
Reply-To: felix@oxley.org
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc6-mm2 Won't compile on PowerBook
Date: Sat, 10 Jun 2006 13:49:52 +0100
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, linux-ppc@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606101349.52995.felix@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suse 10.1.
rc6 compiles OK without -mm2 patch.

  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  KLIBCCC usr/dash/builtins.o
  KLIBCCC usr/dash/init.o
  KLIBCLD usr/dash/sh
  KLIBCLD usr/dash/sh.shared
  CC      arch/powerpc/kernel/signal_32.o
arch/powerpc/kernel/signal_32.c: In function ‘handle_rt_signal’:
arch/powerpc/kernel/signal_32.c:763: error: request for member ‘vdso_base’ in 
something not a structure or union
arch/powerpc/kernel/signal_32.c:766: error: request for member ‘vdso_base’ in 
something not a structure or union
arch/powerpc/kernel/signal_32.c: In function ‘handle_signal’:
arch/powerpc/kernel/signal_32.c:1037: error: request for member ‘vdso_base’ in 
something not a structure or union
arch/powerpc/kernel/signal_32.c:1040: error: request for member ‘vdso_base’ in 
something not a structure or union
make[1]: *** [arch/powerpc/kernel/signal_32.o] Error 1
make: *** [arch/powerpc/kernel] Error 2
