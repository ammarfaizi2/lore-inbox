Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271415AbTHHQIM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 12:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271418AbTHHQIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 12:08:12 -0400
Received: from dhcp17.kph.uni-mainz.de ([134.93.135.217]:29087 "EHLO
	acucb1.irb.hr") by vger.kernel.org with ESMTP id S271415AbTHHQIK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 12:08:10 -0400
Subject: PROBLEM: Compile Break 2.6.0-test2
From: Michael Joy <mdj00b@acu.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060358888.12163.4.camel@acucb1.irb.hr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 08 Aug 2003 18:08:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    
[2.] Full description of the problem/report:
[3.] Keywords (i.e., modules, networking, kernel):
[4.] Kernel version (from /proc/version):
[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment
Reading specs from /usr/lib/gcc-lib/i586-mandrake-linux-gnu/3.2.2/specs
Configured with: ../configure --prefix=/usr --libdir=/usr/lib
--with-slibdir=/lib --mandir=/usr/share/man --infodir=/usr/share/info
--enable-shared --enable-threads=posix --disable-checking
--enable-long-long --enable-__cxa_atexit
--enable-languages=c,c++,ada,f77,objc,java
--host=i586-mandrake-linux-gnu --with-system-zlib
Thread model: posix
gcc version 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk)

Problem Invoked:

In file included from drivers/char/riscom8.c:51:
drivers/char/riscom8.h:84: field `tqueue' has incomplete type
drivers/char/riscom8.h:85: field `tqueue_hangup' has incomplete type
drivers/char/riscom8.c:84: warning: type defaults to `int' in
declaration of `DECLARE_TASK_QUEUE'
drivers/char/riscom8.c:84: warning: parameter names (without types) in
function declaration
drivers/char/riscom8.c:135: confused by earlier errors, bailing out
make[2]: *** [drivers/char/riscom8.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

Michael Joy
ACU - Physics Systems Admin
mdj00b@acu.edu
