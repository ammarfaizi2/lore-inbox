Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132002AbQKKBIT>; Fri, 10 Nov 2000 20:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132038AbQKKBIJ>; Fri, 10 Nov 2000 20:08:09 -0500
Received: from cannet.com ([206.156.188.2]:39952 "HELO mail.cannet.com")
	by vger.kernel.org with SMTP id <S132002AbQKKBIB>;
	Fri, 10 Nov 2000 20:08:01 -0500
Message-ID: <3A0C9B74.114053B6@cannet.com>
Date: Fri, 10 Nov 2000 20:05:56 -0500
From: root <whtdrgn@mail.cannet.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.17 wont compile on AMD k6@-550
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel hackers,

    I am having problems with compiling a kernel on an AMD K62-550.
I am running Red Hat 6.2, and am getting error messages like this:

cc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce
-m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686   -c
-o tcp_output.o tcp_output.c
cc: Internal compiler error: program cc1 got fatal signal 11
make[3]: *** [tcp_output.o] Error 1
make[3]: Leaving directory `/usr/src/linux/net/ipv4'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/net/ipv4'
make[1]: *** [_subdir_ipv4] Error 2
make[1]: Leaving directory `/usr/src/linux/net'
make: *** [_dir_net] Error 2

my cpuinfo is as follows:

processor : 0
vendor_id : AuthenticAMD
cpu family : 5
model  : 8
model name : AMD-K6(tm) 3D processor
stepping : 12
cpu MHz  : 551.243978
fdiv_bug : no
hlt_bug  : no
sep_bug  : no
f00f_bug : no
coma_bug : no
fpu  : yes
fpu_exception : yes
cpuid level : 1
wp  : yes
flags  : fpu vme de pse tsc msr mce cx8 sep mtrr pge mmx 3dnow
bogomips : 1101.00

This is the first time I have posted anyting kernel compile related so
let me know what you need.

Thanks in Advanced,

--
Kind Regards
Timothy A. DeWees

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
