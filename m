Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269837AbRHMVri>; Mon, 13 Aug 2001 17:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269842AbRHMVr3>; Mon, 13 Aug 2001 17:47:29 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:17804 "EHLO
	inet-mail4.oraclecorp.com") by vger.kernel.org with ESMTP
	id <S269837AbRHMVrO>; Mon, 13 Aug 2001 17:47:14 -0400
Message-ID: <3B784B68.B3C35C6C@oracle.com>
Date: Mon, 13 Aug 2001 23:49:28 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.9-pre2 breaks UFS as a module
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[2]: Entering directory `/share/src/linux-2.4.9-pre2/fs/ufs'
gcc -D__KERNEL__ -I/share/src/linux-2.4.9-pre2/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686
-DMODULE   -c -o file.o file.c
file.c:80: `generic_file_open' undeclared here (not in a function)
file.c:80: initializer element is not constant
file.c:80: (near initialization for `ufs_file_operations.open')
make[2]: *** [file.o] Error 1
make[2]: Leaving directory `/share/src/linux-2.4.9-pre2/fs/ufs'
make[1]: *** [_modsubdir_ufs] Error 2
make[1]: Leaving directory `/share/src/linux-2.4.9-pre2/fs'
make: *** [_mod_fs] Error 2

--alessandro

 "this is no time to get cute, it's a mad dog's promenade
  so walk tall, or baby don't walk at all"
                (Bruce Springsteen, 'New York City Serenade')
