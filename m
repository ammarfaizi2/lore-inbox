Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSIAF4m>; Sun, 1 Sep 2002 01:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSIAF4m>; Sun, 1 Sep 2002 01:56:42 -0400
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:17984 "HELO
	laura.worldcontrol.com") by vger.kernel.org with SMTP
	id <S315406AbSIAF4l>; Sun, 1 Sep 2002 01:56:41 -0400
From: brian@worldcontrol.com
Date: Sat, 31 Aug 2002 23:00:45 -0700
To: linux-kernel@vger.kernel.org
Subject: linux-2.5.33/include/linux/ptrace.h:41: dereferencing pointer to incomplete type
Message-ID: <20020901060045.GA9128@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.5.33

Did I do something wrong?

make[3]: Entering directory `/usr/src/linux-2.5.33/drivers/net/wireless'
  gcc -Wp,-MD,./.hermes.o.d -D__KERNEL__ -I/usr/src/linux-2.5.33/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -nostdinc -iwithprefix include -DMODULE -include /usr/src/linux-2.5.33/include/linux/modversions.h   -DKBUILD_BASENAME=hermes -DEXPORT_SYMTAB  -c -o hermes.o hermes.c
In file included from hermes.c:48:
/usr/src/linux-2.5.33/include/linux/ptrace.h: In function `ptrace_link':
/usr/src/linux-2.5.33/include/linux/ptrace.h:41: dereferencing pointer to incomplete type
/usr/src/linux-2.5.33/include/linux/ptrace.h: In function `ptrace_unlink':
/usr/src/linux-2.5.33/include/linux/ptrace.h:46: dereferencing pointer to incomplete type
make[3]: *** [hermes.o] Error 1


-- 
Brian Litzinger
