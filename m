Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272620AbRIPRhf>; Sun, 16 Sep 2001 13:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272590AbRIPRhZ>; Sun, 16 Sep 2001 13:37:25 -0400
Received: from law2-f141.hotmail.com ([216.32.181.141]:27404 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S272620AbRIPRhR>;
	Sun, 16 Sep 2001 13:37:17 -0400
X-Originating-IP: [212.198.0.96]
From: "james bond" <difda@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: fils_ubu@noos.fr
Subject: parse error on compiling a 2.4.9 kernel
Date: Sun, 16 Sep 2001 17:37:35 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW2-F141I1wvaKHY5U00005080@hotmail.com>
X-OriginalArrivalTime: 16 Sep 2001 17:37:35.0756 (UTC) FILETIME=[45C534C0:01C13ED6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so hello all , and thank's for leeding me to format my windobe :)
the problem is verry simple
when i configure my kernel i select ntfs support and then i launch a 
compiling process "make dep , make clean , make bzImage "
and then i have this message :

----------------------------------------------------------------------

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
make[3]: Leaving directory `/usr/src/linux-2.4.9/fs/ntfs'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.9/fs/ntfs'
make[1]: *** [_subdir_ntfs] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.9/fs'
make: *** [_dir_fs] Error 2


----------------------------------------------------------------------
when i désélect ntfs every thing is ok ,
i m using a slack 8.0
and have gcc version 2.95.3 20010315 (release)
i think that there is no need of any cat /proc/cpuinfo

now i m using a linux 2.4.7 and every thing is ok
thank's for answering
sorry for my poor english

electonicaly yours



----------------------------------------------------------------------
i have a dream , that one day every computer gona be under linux

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

