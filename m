Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274774AbRKFFMX>; Tue, 6 Nov 2001 00:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275082AbRKFFMN>; Tue, 6 Nov 2001 00:12:13 -0500
Received: from mx5.port.ru ([194.67.57.15]:28947 "EHLO smtp5.port.ru")
	by vger.kernel.org with ESMTP id <S274774AbRKFFMD>;
	Tue, 6 Nov 2001 00:12:03 -0500
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200111060513.fA65DqZ26051@vegae.deep.net>
Subject: 3.0.2 breaks linux-2.4.13-ac8 in tcp.c
To: gcc-bugs@gcc.gnu.org
Date: Tue, 6 Nov 2001 08:13:52 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     well, not too much to add, maybe except that the RAM is ok and CPU is not
   OC`ed...

make[3]: Entering directory `/usr/src/linux/net/ipv4'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586    -c -o tcp.o tcp.c
In file included from /usr/src/linux/include/net/checksum.h:33,
                 from /usr/src/linux/include/net/tcp.h:30,
                 from tcp.c:256:
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string literals are deprecated
/usr/src/linux/include/asm/checksum.h:105:17: warning: multi-line string literals are deprecated
/usr/src/linux/include/asm/checksum.h:121:13: warning: multi-line string literals are deprecated
/usr/src/linux/include/asm/checksum.h:161:17: warning: multi-line string literals are deprecated
tcp.c: In function `tcp_close':
tcp.c:1978: Internal compiler error in rtx_equal_for_memref_p, at alias.c:1121
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.

cheers, Samium Gromoff
