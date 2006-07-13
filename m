Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWGMKzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWGMKzo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 06:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWGMKzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 06:55:44 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:56265 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751468AbWGMKzn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 06:55:43 -0400
Subject: Linker error with latest tree on EM64T
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 13 Jul 2006 12:56:00 +0200
Message-Id: <1152788160.4838.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when trying to build the latest tree on an EM64T Dual-Core, I am getting
this error:

  LD      .tmp_vmlinux1
init/built-in.o: In function `try_name':
do_mounts.c:(.text+0x51d): undefined reference to `__stack_chk_fail'
init/built-in.o: In function `name_to_dev_t':
(.text+0x797): undefined reference to `__stack_chk_fail'
init/built-in.o: In function `mount_block_root':
(.init.text+0x823): undefined reference to `__stack_chk_fail'
init/built-in.o: In function `md_run_setup':
(.init.text+0x1131): undefined reference to `__stack_chk_fail'
init/built-in.o: In function `do_header':
initramfs.c:(.init.text+0x24a4): undefined reference to `__stack_chk_fail'
arch/x86_64/kernel/built-in.o:(.text+0x2f52): more undefined references to `__st
ack_chk_fail' follow
make: *** [.tmp_vmlinux1] Error 1

Does anybody have an idea?

Regards

Marcel


