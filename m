Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286250AbRLJMOV>; Mon, 10 Dec 2001 07:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286246AbRLJMOM>; Mon, 10 Dec 2001 07:14:12 -0500
Received: from aef.wh.Uni-Dortmund.DE ([129.217.129.132]:51447 "EHLO
	ReneEngelhard.local") by vger.kernel.org with ESMTP
	id <S286245AbRLJMNz>; Mon, 10 Dec 2001 07:13:55 -0500
Date: Mon, 10 Dec 2001 13:14:25 +0100
From: Rene Engelhard <mail@rene-engelhard.de>
To: linux-kernel@vger.kernel.org
Subject: Compile error 2.4.1-pre8
Message-ID: <20011210131425.A24397@rene-engelhard.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm gonna want to start with helping developing the kernel and I have
the following compile error at make bzImage from 2.5.1-pre8:

[...]
gcc -D__KERNEL__ -I/home/rene/Entwicklung/Linux-Kernel/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o ide-floppy.o ide-floppy.c
ide-floppy.c: In function `idefloppy_end_request':
ide-floppy.c:699: warning: comparison between pointer and integer
ide-floppy.c:699: warning: comparison between pointer and integer
ide-floppy.c: In function `idefloppy_queue_pc_head':
ide-floppy.c:779: incompatible types in assignment
ide-floppy.c: In function `idefloppy_create_rw_cmd':
ide-floppy.c:1214: warning: comparison between pointer and integer
ide-floppy.c: In function `idefloppy_do_request':
ide-floppy.c:1243: switch quantity not an integer
ide-floppy.c:1258: warning: unsigned int format, pointer arg (arg 2)
ide-floppy.c:1246: warning: unreachable code at beginning of switch statement
ide-floppy.c: In function `idefloppy_queue_pc_tail':
ide-floppy.c:1276: incompatible types in assignment
make[3]: *** [ide-floppy.o] Error 1
make[3]: Leaving directory `/home/rene/Entwicklung/Linux-Kernel/linux/drivers/ide'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/home/rene/Entwicklung/Linux-Kernel/linux/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
make[1]: Leaving directory `/home/rene/Entwicklung/Linux-Kernel/linux/drivers'
make: *** [_dir_drivers] Error 2

What is that supposed to be?

Rene
-- 
Omnis enim res, quae dando non deficit, dum habetur et non datur,
nondum habetur, quomodo habenda est [Aurelius Augustinus, 4. Jhd]
Erklärung und Übsersetzung: http://fsfeurope.org/order/
öffentlicher GnuPG-Schlüssel: Mail an gnupgkey@rene-engelhard.de
