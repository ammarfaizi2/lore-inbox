Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287633AbSBOISY>; Fri, 15 Feb 2002 03:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287607AbSBOISP>; Fri, 15 Feb 2002 03:18:15 -0500
Received: from 203-173-179-8.ultrawholesale.com.au ([203.173.179.8]:9972 "HELO
	gateway.mmtnetworks.com.au") by vger.kernel.org with SMTP
	id <S287591AbSBOISJ>; Fri, 15 Feb 2002 03:18:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Jon L. Miller" <jlmiller@mmtnetworks.com.au>
Organization: MMT Networks
To: linux-kernel@vger.kernel.org
Subject: problem compiling the ntfs fs in kernel
Date: Fri, 15 Feb 2002 16:29:03 +0800
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020215081812Z287591-13996+23644@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While compling kernel version 2.4.9 with the NTFS in the kernel we got the 
following errors, would appreciate some info on what happen.

make[2]: Entering directory `/usr/src/linux-2.4.9/linux/fs/ntfs'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.4.9/linux/fs/ntfs'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.9/linux/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686  -DNTFS_VERSION=\"1.1.16\"   -c -o unistr.o unistr.c
unistr.c: In function `ntfs_collate_names':
unistr.c:99: warning: implicit declaration of function `min'
unistr.c:99: parse error before `unsigned'
unistr.c:99: parse error before `)'
unistr.c:97: warning: `c1' might be used uninitialized in this function
unistr.c: At top level:
unistr.c:118: parse error before `if'
unistr.c:123: warning: type defaults to `int' in declaration of `c1'
unistr.c:123: `name1' undeclared here (not in a function)
unistr.c:123: warning: data definition has no type or storage class
unistr.c:124: parse error before `if'
make[3]: *** [unistr.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.9/linux/fs/ntfs'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.9/linux/fs/ntfs'
make[1]: *** [_subdir_ntfs] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.9/linux/fs'
make: *** [_dir_fs] Error 2
