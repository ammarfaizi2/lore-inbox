Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132075AbQLaBVo>; Sat, 30 Dec 2000 20:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132087AbQLaBVf>; Sat, 30 Dec 2000 20:21:35 -0500
Received: from lima.epix.net ([199.224.64.56]:11675 "EHLO lima.epix.net")
	by vger.kernel.org with ESMTP id <S132075AbQLaBV0>;
	Sat, 30 Dec 2000 20:21:26 -0500
Message-ID: <3A4E3D6D.4D64E13@epix.net>
Date: Sat, 30 Dec 2000 19:54:21 +0000
From: Tony Spinillo <tspin@epix.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: TEST13-PRE7 - Nvidia Kernel Module Compile Problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The nvidia kernel module (from www.nvidia.com) has compiled and loaded
correctly with all test13-pre series up to pre6. I just tried to
compile and load under pre7.
I got the following:
nv.c:860:unknown field `unmap' specified in initializer
nv.c:860:warning: initialization from incompatible pointer type
make:*** [nv.o] Error 1

Is this due to a problem with the recent makefile changes or a problem
with the nvidia module?

Thanks!

Tony

The output for ver_linux:

Kernel modules         2.3.23
Gnu C                  egcs-2.91.66
Gnu Make               3.79.1
Binutils               2.10.0.24
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.7
Mount                  2.10o
Net-tools              1.57
Console-tools          0.2.3
Sh-utils               2.0
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
