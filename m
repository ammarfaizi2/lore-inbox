Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTL1OhP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 09:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTL1OhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 09:37:15 -0500
Received: from web13308.mail.yahoo.com ([216.136.175.44]:51869 "HELO
	web13308.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261506AbTL1OhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 09:37:02 -0500
Message-ID: <20031228143700.8965.qmail@web13308.mail.yahoo.com>
Date: Sun, 28 Dec 2003 06:37:00 -0800 (PST)
From: reza kahar <rezakahar@yahoo.com>
Subject: Fwd: need your help
To: linux-kernel@vger.kernel.org, kraxel@bytesex.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-969214821-1072622220=:7600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-969214821-1072622220=:7600
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline


Note: forwarded message attached.

And Brian Bidulock, the one who made sctp open source
for linux, said to me don't compile with gcc3
I use linux Red Hat 9, i don't know in red hat 9 use
what gcc..but, i don't know to how to change gcc. I've
down loaded gcc-2.95.3 and gcc-3.3.2 but i 'm still in
dificultness in istall of its.
Any Help?
Thank you very much


make[2]: Entering directory `/usr/src/linux/net'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686  
-DKBUILD_BASENAME=netsyms  -DEXPORT_SYMTAB -c
netsyms.c
In file included from
/usr/src/linux/include/net/checksum.h:33,
                 from netsyms.c:24:
/usr/src/linux/include/asm/checksum.h:72:30: warning:
multi-line string literals are deprecated
/usr/src/linux/include/asm/checksum.h:105:17: warning:
multi-line string literals are deprecated
/usr/src/linux/include/asm/checksum.h:121:13: warning:
multi-line string literals are deprecated
/usr/src/linux/include/asm/checksum.h:161:17: warning:
multi-line string literals are deprecated
netsyms.c:385: `ipv4_specific' undeclared here (not in
a function)
netsyms.c:385: initializer element is not constant
netsyms.c:385: (near initialization for
`__ksymtab_ipv4_specific.value')
make[2]: *** [netsyms.o] Error 1
make[2]: Leaving directory `/usr/src/linux/net'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/net'
make: *** [_dir_net] Error 2



__________________________________
Do you Yahoo!?
New Yahoo! Photos - easier uploading and sharing.
http://photos.yahoo.com/
--0-969214821-1072622220=:7600
Content-Type: message/rfc822

Received: from [167.205.22.104] by web13301.mail.yahoo.com via HTTP; Sat, 27 Dec 2003 15:48:37 PST
Date: Sat, 27 Dec 2003 15:48:37 -0800 (PST)
From: reza kahar <rezakahar@yahoo.com>
Subject: need your help
To: Wolfgang.Friess@dlr.de
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Length: 922

Hi Wolfgang,
How do you do?
My name reza,
I read your email in archive milis 3 April 1996
about undeclare symbols in net/netsyms.c
you said that it's just a foolish configuration

i've a same problem with you.. i tried to compile
kernel 2.4.18 that have been patched with
/usr/src/linux-sctp/patch-total-0.2.16.gz
and there is in error when make bzImage at
net/netsyms.c
said "ipv4_specified undeclared here"

Actually i have already sucsess compiled it before.But
i haven't set CONFIG_SCTP. And i strated agai from
beginig..and i set CONFIG_SCTP=m, but when i compile
it, there is a problem in make bzImage that i've
mentioned it above..

I think, i do a foolish configuration, but i don't
know, where is the problem
can you help me?show me the way?
your help is very needed

Thank you verymuch

__________________________________
Do you Yahoo!?
New Yahoo! Photos - easier uploading and sharing.
http://photos.yahoo.com/

--0-969214821-1072622220=:7600--
