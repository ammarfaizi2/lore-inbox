Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315451AbSGBBCH>; Mon, 1 Jul 2002 21:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315971AbSGBBCG>; Mon, 1 Jul 2002 21:02:06 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:44306 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S315451AbSGBBCF>;
	Mon, 1 Jul 2002 21:02:05 -0400
Date: Mon, 1 Jul 2002 17:31:25 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: 2.5.24 : fs/intermezzo/psdev.c compile error
Message-ID: <Pine.LNX.4.44.0207011726210.860-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   Does a patch exist for the following compile error? I thought that one 
existed, but can't find one in the linux-kernel archives. If not, I can 
work on one.
Regards,
Frank

psdev.c: In function `presto_psdev_write':
psdev.c:138: warning: unused variable `error'
psdev.c: In function `presto_psdev_ioctl':
psdev.c:279: warning: unused variable `error'
psdev.c:278: warning: unused variable `tmp'
psdev.c:277: warning: unused variable `user_readmount'
psdev.c:275: warning: unused variable `outlen'
psdev.c:275: warning: unused variable `len'
psdev.c:274: warning: unused variable `minor'
psdev.c:289: `len' undeclared (first use in this function)
psdev.c:289: (Each undeclared identifier is reported only once
psdev.c:289: for each function it appears in.)
psdev.c:289: `readmount' undeclared (first use in this function)
psdev.c:290: `minor' undeclared (first use in this function)
psdev.c:291: `tmp' undeclared (first use in this function)
psdev.c:297: `outlen' undeclared (first use in this function)
psdev.c:309: `error' undeclared (first use in this function)
psdev.c:311: `user_readmount' undeclared (first use in this function)
psdev.c:323: case label not within a switch statement
psdev.c:348: case label not within a switch statement
psdev.c:387: case label not within a switch statement
psdev.c:425: case label not within a switch statement
psdev.c:473: case label not within a switch statement
psdev.c:521: case label not within a switch statement
psdev.c:551: warning: statement with no effect
psdev.c:591: case label not within a switch statement
psdev.c:606: case label not within a switch statement
psdev.c:607: case label not within a switch statement
psdev.c:656: case label not within a switch statement
psdev.c:680: case label not within a switch statement
psdev.c:694: case label not within a switch statement
psdev.c:708: case label not within a switch statement
psdev.c:722: case label not within a switch statement
psdev.c:736: case label not within a switch statement
psdev.c:750: case label not within a switch statement
psdev.c:764: case label not within a switch statement
psdev.c:774: incompatible type for argument 3 of `lento_mknod'
psdev.c:779: case label not within a switch statement
psdev.c:882: case label not within a switch statement
psdev.c:884: warning: unused variable `error'
psdev.c:904: case label not within a switch statement
psdev.c:919: case label not within a switch statement
psdev.c:921: warning: unused variable `error'
psdev.c:960: case label not within a switch statement
psdev.c:962: warning: unused variable `error'
psdev.c:1002: case label not within a switch statement
psdev.c:1035: case label not within a switch statement
psdev.c:1037: warning: unused variable `error'
psdev.c:1070: case label not within a switch statement
psdev.c:1173: case label not within a switch statement
psdev.c:1215: default label not within a switch statement
psdev.c: At top level:
psdev.c:1223: parse error before `return'
make[2]: *** [psdev.o] Error 1
make[2]: Leaving directory `/usr/src/linux/fs/intermezzo'
make[1]: *** [intermezzo] Error 2
make[1]: Leaving directory `/usr/src/linux/fs'
make: *** [fs] Error 2

