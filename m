Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129617AbQJ0Uo7>; Fri, 27 Oct 2000 16:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130347AbQJ0Uov>; Fri, 27 Oct 2000 16:44:51 -0400
Received: from janus.hosting4u.net ([209.15.2.37]:4367 "HELO
	janus.hosting4u.net") by vger.kernel.org with SMTP
	id <S129617AbQJ0UoZ>; Fri, 27 Oct 2000 16:44:25 -0400
Message-ID: <39F9E6C7.1C51B730@a2zis.com>
Date: Fri, 27 Oct 2000 22:34:15 +0200
From: Remi Turk <remi@a2zis.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test10-pre5 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Not reproducable crc error at boot :-(
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
when booting pre5 I got a crc-error while uncompressing
the kernel this morning. (/usr/src/linux/lib/inflate.c:1166 AFAICS)
Rebooting didn't trigger it again and it's the first time I ever saw it.

I've never had any SIG11 problems while compiling kernels so I wouldn't
expect bad RAM. (Normal people probably run Seti@home,
I run "while make bzImage; do date >> /tmp/kcompile; make clean; done"
;-)

OTOH, it's not reproducable which seems an indicator for hardware
trouble :-(

Does anybody have any ideas?

Linux version 2.4.0-test10-pre5 (src@localhost.localdomain)
(gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release))
#1 Tue Oct 24 17:14:24 CEST 2000

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 5
model		: 8
model name	: AMD-K6(tm) 3D processor
stepping	: 0
cpu MHz		: 350.000809
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 sep mmx 3dnow
bogomips	: 699.60

-- 
Linux 2.4.0-test10-pre5 #1 Tue Oct 24 17:14:24 CEST 2000
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
