Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbUKODrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbUKODrA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 22:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbUKODon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 22:44:43 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:5342 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261466AbUKODnL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 22:43:11 -0500
Subject: Problem with sparse on a Debian system
From: Marcel Holtmann <marcel@holtmann.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 15 Nov 2004 04:43:02 +0100
Message-Id: <1100490182.7208.2.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when calling "make C=2" on a Debian Sid I got the following errors and I
don't know why:

  CHK     include/linux/version.h
  CHECK   scripts/mod/empty.c
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHECK   init/main.c
/usr/lib/gcc-lib/i486-linux/3.3.5/include/asm/posix_types.h:29:35: warning: no newline at end of file
/usr/lib/gcc-lib/i486-linux/3.3.5/include/asm/posix_types.h:13:11: error: unable to open 'features.h'
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2

Regards

Marcel


