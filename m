Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129759AbRAIRkP>; Tue, 9 Jan 2001 12:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129627AbRAIRkH>; Tue, 9 Jan 2001 12:40:07 -0500
Received: from jesus.ksc.co.th ([203.107.130.99]:29702 "EHLO jesus.ksc.co.th")
	by vger.kernel.org with ESMTP id <S131231AbRAIRjx>;
	Tue, 9 Jan 2001 12:39:53 -0500
Date: Wed, 10 Jan 2001 00:39:35 +0700
From: Prasong Aroonruviwat <psa@ksc.net.th>
To: linux-kernel@vger.kernel.org
Subject: Please help may be off topic
Message-ID: <20010110003935.A3008@jesus.ksc.co.th>
Reply-To: psa@jesus.ksc.co.th
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

        I'm sorry if this not right to post here.
        I've got this error after upgrade my system.

/usr/include/stdlib.h:208: undefined reference to `__srandom'
/usr/include/stdlib.h:206: undefined reference to `__random'
/usr/libip.a(net.o): In function `net_ip_connect':
/home/seshadri/lib/net.c:281: undefined reference to `__setjmp'
/usr/lib/libip.a(net.o): In function `net_connect':
/home/seshadri/lib/net.c:387: undefined reference to `__setjmp'
/usr/lib/libip.a(net.o): In function `net_read':
/home/seshadri/lib/net.c:729: undefined reference to `__setjmp'
/usr/lib/libcrypto.a(x509_def.o): In function `X509_load_verify_locations':
x509_def.o(.text+0x133): undefined reference to `_xstat'
x509_def.o(.text+0x174): undefined reference to `_xstat'
/usr/lib/libcrypto.a(x509_crt.o): In function `X509_get_cert':
x509_crt.o(.text+0x2a2): undefined reference to `_xstat'
/usr/lib/libcrypto.a(read_pwd.o): In function `read_pw':
read_pwd.o(.text+0x1f9): undefined reference to `__setjmp'

        I can't make my program.
        My environment is below:

$ gcc -V
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.2/specs
gcc version 2.95.2 20000220 (Debian GNU/Linux)

$ ld -v
GNU ld version 2.9.5 (with BFD 2.9.5.0.37)

$ ldd -v
ldd: version 1.9.11

Regards,
Prasong Aroonruviwat
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
