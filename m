Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbSKIDlO>; Fri, 8 Nov 2002 22:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264634AbSKIDlO>; Fri, 8 Nov 2002 22:41:14 -0500
Received: from ns.telematica.com.uy ([200.40.82.218]:45578 "EHLO
	telematica.com.uy") by vger.kernel.org with ESMTP
	id <S264631AbSKIDlM>; Fri, 8 Nov 2002 22:41:12 -0500
Subject: No such file or directory when compiling 2.5.46: sd.h
From: Mario Pereyra <beto@telematica.com.uy>
To: Linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Nov 2002 00:49:40 -0300
Message-Id: <1036813787.667.74.camel@dbeto.gmc.com.uy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following error when compiling 2.5.46

Where is that file?

--------

gcc -Wp,-MD,drivers/message/i2o/.i2o_scsi.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i386 -Iarch/i386/mach-generic -nostdinc -iwithprefix include   
-DKBUILD_BASENAME=i2o_scsi   -c -o drivers/message/i2o/i2o_scsi.o
drivers/message/i2o/i2o_scsi.c
drivers/message/i2o/i2o_scsi.c:60: ../../scsi/sd.h: No such file or
directory
make[3]: *** [drivers/message/i2o/i2o_scsi.o] Error 1
make[2]: *** [drivers/message/i2o] Error 2
make[1]: *** [drivers/message] Error 2
make: *** [drivers] Error 2



