Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267377AbTALSCQ>; Sun, 12 Jan 2003 13:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267379AbTALSCQ>; Sun, 12 Jan 2003 13:02:16 -0500
Received: from [64.8.50.187] ([64.8.50.187]:36495 "EHLO mta5.adelphia.net")
	by vger.kernel.org with ESMTP id <S267377AbTALSCP>;
	Sun, 12 Jan 2003 13:02:15 -0500
Subject: "make install" error: No module raid5 found for kernel 2.5.56
From: jeff millar <wa1hco@adelphia.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Jan 2003 13:12:37 -0500
Message-Id: <1042395158.19325.7.camel@maggie>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any ideas about the following problem?

The following error shows up at the end of "make install" after a
successful make and make modules_install.  I've tried making with raid5
both modular and compiled in and with various combinations of other raid
module options.  Same error each time.  Also tried after a make
mrproper.

This is with stock 2.5.56 on a Redhat 8.0 box with the 0.9.8
module-init-tools

============================================
<....> 
Kernel: arch/i386/boot/bzImage is ready
sh arch/i386/boot/install.sh 2.5.56 arch/i386/boot/bzImage System.map ""
No module raid5 found for kernel 2.5.56
make[1]: *** [install] Error 1
make: *** [install] Error 2





