Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263822AbTIIAEU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 20:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263827AbTIIAEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 20:04:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:2199 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263822AbTIIAEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 20:04:14 -0400
Subject: Re: Linux 2.6.0-test5 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1063065853.10623.449.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 08 Sep 2003 17:04:13 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile statistics: 2.6.0-test5
Compiler: gcc 3.2.2
Script: http://developer.osdl.org/~cherry/compile/compregress.sh

Note: the numbers look drastically better, but this is skewed
      by the fact that CONFIG_CLEAN_COMPILE is now the default
      for defconfig and allmodconfig.

               bzImage       bzImage        modules
             (defconfig)  (allmodconfig) (allmodconfig)

2.6.0-test5  0 warnings     0 warnings   305 warnings
             0 errors       0 errors       5 errors

2.6.0-test4  0 warnings     3 warnings   1016 warnings
             0 errors       0 errors       34 errors

2.6.0-test3  0 warnings     7 warnings    984 warnings
             0 errors       9 errors       42 errors

2.6.0-test2  0 warnings     7 warnings   1201 warnings
             0 errors       9 errors       43 errors

2.6.0-test1  0 warnings     8 warnings   1319 warnings
             0 errors       9 errors       38 errors



Compile statistics for 2.5 kernels and 2.6 kernels are at:
http://developer.osdl.org/~cherry/compile/

BTW, there are ia64 compile statistics at this URL now as well.

Warning summary:

   drivers/atm: 8 warnings, 0 errors
   drivers/cdrom: 4 warnings, 0 errors
   drivers/char: 6 warnings, 0 errors
   drivers/i2c: 1 warnings, 0 errors
   drivers/ide: 30 warnings, 0 errors
   drivers/isdn: 1 warnings, 0 errors
   drivers/media: 5 warnings, 0 errors
   drivers/message: 1 warnings, 0 errors
   drivers/mtd: 25 warnings, 0 errors
   drivers/pcmcia: 3 warnings, 0 errors
   drivers/scsi/pcmcia: 4 warnings, 0 errors
   drivers/scsi/sym53c8xx_2: 1 warnings, 0 errors
   drivers/scsi: 53 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/telephony: 5 warnings, 0 errors
   drivers/video/aty: 3 warnings, 0 errors
   drivers/video/console: 2 warnings, 0 errors
   drivers/video/matrox: 5 warnings, 0 errors
   drivers/video/sis: 1 warnings, 0 errors
   drivers/video: 8 warnings, 0 errors
   fs/afs: 2 warnings, 0 errors
   fs/intermezzo: 1 warnings, 0 errors
   fs/jffs: 2 warnings, 0 errors
   fs/nfsd: 1 warnings, 0 errors
   fs/smbfs: 2 warnings, 0 errors
   sound/isa: 3 warnings, 0 errors
   sound/oss: 49 warnings, 0 errors

Error summary:

   drivers/block: 2 warnings, 1 errors
   drivers/net: 0 warnings, 1 errors
   drivers/net: 67 warnings, 1 errors
   drivers/scsi/aic7xxx: 0 warnings, 1 errors
   net: 13 warnings, 1 errors

John

