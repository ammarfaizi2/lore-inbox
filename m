Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313133AbSC1LRK>; Thu, 28 Mar 2002 06:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313136AbSC1LRB>; Thu, 28 Mar 2002 06:17:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:43124 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S313133AbSC1LQv>;
	Thu, 28 Mar 2002 06:16:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Sebastian Roth <xsebbi@gmx.de>
Reply-To: xsebbi@gmx.de
Message-Id: <200203281216.32590@xsebbi.de>
To: linux-kernel@vger.kernel.org
Subject: [2.5.7-dj2] Compile Error
Date: Thu, 28 Mar 2002 12:17:43 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

make bzImage says:
make[1]: Entering directory `/usr/src/linux-2.5-dj/kernel'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.5-dj/kernel'
gcc -D__KERNEL__ -I/usr/src/linux-2.5-dj/include -Wall 
-Wstrict-prototypes -Wno-
trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpref
erred-stack-boundary=2 -march=i686 -malign-functions=4    
-DKBUILD_BASENAME=acct
  -c -o acct.o acct.c
acct.c:235: parse error before `do'
acct.c:378: parse error before `do'
acct.c:384: parse error before `&'
acct.c:386: warning: type defaults to `int' in declaration of 
`do_acct_process'
acct.c:386: warning: parameter names (without types) in function 
declaration
acct.c:386: conflicting types for `do_acct_process'
acct.c:297: previous declaration of `do_acct_process'
acct.c:386: warning: data definition has no type or storage class
acct.c:387: warning: type defaults to `int' in declaration of `fput'
acct.c:387: warning: parameter names (without types) in function 
declaration
acct.c:387: conflicting types for `fput'
/usr/src/linux-2.5-dj/include/linux/file.h:36: previous declaration of 
`fput'
acct.c:387: warning: data definition has no type or storage class
acct.c:388: parse error before `}'
make[2]: *** [acct.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5-dj/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5-dj/kernel'
make: *** [_dir_kernel] Error 2

just for information.

		Sebastian
