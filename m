Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbTFJKTU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 06:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbTFJKTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 06:19:20 -0400
Received: from webmail26.rediffmail.com ([203.199.83.148]:63623 "HELO
	rediffmail.com") by vger.kernel.org with SMTP id S261568AbTFJKTG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 06:19:06 -0400
Date: 10 Jun 2003 10:32:40 -0000
Message-ID: <20030610103240.3422.qmail@webmail26.rediffmail.com>
MIME-Version: 1.0
From: "jairam nair" <jairamnair@rediffmail.com>
Reply-To: "jairam nair" <jairamnair@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: Problem while Crosscompiling Ksymoops
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,
    I am trying to cross compile ksymoops-2.4.9 for Strong ARM. 
But i
am getting a segmentation Fault. The error messages is as below.
    Can anybody tell me what should be given for DEF_MAP, since in 
the
target machine there is no System.map file.

  Can anybody give some idea on this.

Thanks and regards
      Jairam

arm-linux-gcc -Dlinux -Wall -Wno-conversion -Waggregate-return
-Wstrict-prototypes -Wmissing-prototypes
-DINSTALL_PREFIX="\"/skiff/local\"" -DCROSS="\"arm-linux-\""
-DDEF_KSYMS=\"/proc/ksyms\" -DDEF_LSMOD=\"/proc/modules\"
-DDEF_OBJECTS=\"/lib/modules/*r/\"
-DDEF_MAP=\"/usr/src/linux/System.map\" -DDEF_ARCH=\"arm\"
-I/skiff/local/include   -c -o ksymoops.o ksymoops.c
arm-linux-gcc -Dlinux -Wall -Wno-conversion -Waggregate-return
-Wstrict-prototypes -Wmissing-prototypes
-DINSTALL_PREFIX="\"/skiff/local\"" -DCROSS="\"arm-linux-\""
-DDEF_KSYMS=\"/proc/ksyms\" -DDEF_LSMOD=\"/proc/modules\"
-DDEF_OBJECTS=\"/lib/modules/*r/\"
-DDEF_MAP=\"/usr/src/linux/System.map\" -DDEF_ARCH=\"arm\"
-I/skiff/local/include   -c -o io.o io.c
arm-linux-gcc -Dlinux -Wall -Wno-conversion -Waggregate-return
-Wstrict-prototypes -Wmissing-prototypes
-DINSTALL_PREFIX="\"/skiff/local\"" -DCROSS="\"arm-linux-\""
-DDEF_KSYMS=\"/proc/ksyms\" -DDEF_LSMOD=\"/proc/modules\"
-DDEF_OBJECTS=\"/lib/modules/*r/\"
-DDEF_MAP=\"/usr/src/linux/System.map\" -DDEF_ARCH=\"arm\"
-I/skiff/local/include   -c -o ksyms.o ksyms.c
arm-linux-gcc -Dlinux -Wall -Wno-conversion -Waggregate-return
-Wstrict-prototypes -Wmissing-prototypes
-DINSTALL_PREFIX="\"/skiff/local\"" -DCROSS="\"arm-linux-\""
-DDEF_KSYMS=\"/proc/ksyms\" -DDEF_LSMOD=\"/proc/modules\"
-DDEF_OBJECTS=\"/lib/modules/*r/\"
-DDEF_MAP=\"/usr/src/linux/System.map\" -DDEF_ARCH=\"arm\"
-I/skiff/local/include   -c -o map.o map.c
arm-linux-gcc -Dlinux -Wall -Wno-conversion -Waggregate-return
-Wstrict-prototypes -Wmissing-prototypes
-DINSTALL_PREFIX="\"/skiff/local\"" -DCROSS="\"arm-linux-\""
-DDEF_KSYMS=\"/proc/ksyms\" -DDEF_LSMOD=\"/proc/modules\"
-DDEF_OBJECTS=\"/lib/modules/*r/\"
-DDEF_MAP=\"/usr/src/linux/System.map\" -DDEF_ARCH=\"arm\"
-I/skiff/local/include   -c -o misc.o misc.c
arm-linux-gcc -Dlinux -Wall -Wno-conversion -Waggregate-return
-Wstrict-prototypes -Wmissing-prototypes
-DINSTALL_PREFIX="\"/skiff/local\"" -DCROSS="\"arm-linux-\""
-DDEF_KSYMS=\"/proc/ksyms\" -DDEF_LSMOD=\"/proc/modules\"
-DDEF_OBJECTS=\"/lib/modules/*r/\"
-DDEF_MAP=\"/usr/src/linux/System.map\" -DDEF_ARCH=\"arm\"
-I/skiff/local/include   -c -o object.o object.c
arm-linux-gcc -Dlinux -Wall -Wno-conversion -Waggregate-return
-Wstrict-prototypes -Wmissing-prototypes
-DINSTALL_PREFIX="\"/skiff/local\"" -DCROSS="\"arm-linux-\""
-DDEF_KSYMS=\"/proc/ksyms\" -DDEF_LSMOD=\"/proc/modules\"
-DDEF_OBJECTS=\"/lib/modules/*r/\"
-DDEF_MAP=\"/usr/src/linux/System.map\" -DDEF_ARCH=\"arm\"
-I/skiff/local/include   -c -o oops.o oops.c
arm-linux-gcc -Dlinux -Wall -Wno-conversion -Waggregate-return
-Wstrict-prototypes -Wmissing-prototypes
-DINSTALL_PREFIX="\"/skiff/local\"" -DCROSS="\"arm-linux-\""
-DDEF_KSYMS=\"/proc/ksyms\" -DDEF_LSMOD=\"/proc/modules\"
-DDEF_OBJECTS=\"/lib/modules/*r/\"
-DDEF_MAP=\"/usr/src/linux/System.map\" -DDEF_ARCH=\"arm\"
-I/skiff/local/include   -c -o re.o re.c
arm-linux-gcc -Dlinux -Wall -Wno-conversion -Waggregate-return
-Wstrict-prototypes -Wmissing-prototypes
-DINSTALL_PREFIX="\"/skiff/local\"" -DCROSS="\"arm-linux-\""
-DDEF_KSYMS=\"/proc/ksyms\" -DDEF_LSMOD=\"/proc/modules\"
-DDEF_OBJECTS=\"/lib/modules/*r/\"
-DDEF_MAP=\"/usr/src/linux/System.map\" -DDEF_ARCH=\"arm\"
-I/skiff/local/include   -c -o symbol.o symbol.c
arm-linux-gcc io.o ksyms.o ksymoops.o map.o misc.o object.o 
oops.o
re.o symbol.o -Dlinux -Wall -Wno-conversion -Waggregate-return
-Wstrict-prototypes -Wmissing-prototypes
-DINSTALL_PREFIX="\"/skiff/local\"" -DCROSS="\"arm-linux-\""
-DDEF_KSYMS=\"/proc/ksyms\" -DDEF_LSMOD=\"/proc/modules\"
-DDEF_OBJECTS=\"/lib/modules/*r/\"
-DDEF_MAP=\"/usr/src/linux/System.map\" -DDEF_ARCH=\"arm\"
-I/skiff/local/include -L/skiff/local/lib -arm-linux-ld,-Bstatic 
-lbfd
-liberty -arm-linux-ld,-Bdynamic -o ksymoops
collect2: ld terminated with signal 11 [Segmentation fault], 
core
dumped
make: *** [ksymoops] Error 1







___________________________________________________
Get www. mycompany .com and 5 matching email ids.
Just Rs. 1499/ year.
Click here http://www.rediffmailpro.com

