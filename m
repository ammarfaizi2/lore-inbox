Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTJIWTI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 18:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTJIWTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 18:19:08 -0400
Received: from [65.248.4.67] ([65.248.4.67]:7072 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S262086AbTJIWTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 18:19:04 -0400
Message-ID: <000501c38eb3$568edfc0$82e4a7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Kernel List" <linux-kernel@vger.kernel.org>
Subject: Problem to compile kernel 2.4.20
Date: Thu, 9 Oct 2003 19:18:58 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi , i received this error in "make dep" .
Anyone knows how can i fix this ?

make -C nls fastdep
make[4]: Entering directory `/usr/src/linux-2.4.20/fs/nls'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -
Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pip
e -mpreferred-stack-boundary=2 -march=i686  -nostdinc -iwithprefix
include -E -D__GENKSYMS__ nls_base.c
| /sbin/genksyms -p smp_ -k 2.4.20 >
/usr/src/linux-2.4.20/include/linux/modules/nls_base.ver.tmp
mv /usr/src/linux-2.4.20/include/linux/modules/nls_base.ver.tmp
/usr/src/linux-2.4.20/include/linux/modules/nls_base.ver
/usr/src/linux-2.4.20/scripts/mkdep -D__KERNEL__ -I/usr/src/linux-2.4.20/inc
lude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-
common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  
-nostdinc -iwithprefix include -- nls_base.c nls_big5.c nls_cp1250.c
nls_cp1251.c nls_cp1255.c nls_cp437.c nls_cp737.c nls_cp775.c nls_cp850.c
nls_cp852.c nls_cp855.c nls_cp857.c nls_cp860.c nls_cp861.c nls_cp862.c
nls_cp863.c nls_cp864.c nls_cp865.c nls_cp866.c nls_cp869.c nls_cp874.c
nls_cp932.c nls_cp936.c nls_cp949.c nls_cp950.c nls_euc-jp.c nls_euc-kr.c
nls_gb2312.c nls_iso8859-1.c nls_iso8859-13.c nls_iso8859-14.c
nls_iso8859-15.c nls_iso8859-2.c nls_iso8859-3.c nls_iso8859-4.c
nls_iso8859-5.c nls_iso8859-6.c nls_iso8859-7.c nls_iso8859-8.c
nls_iso8859-9.c nls_koi8-r.c nls_koi8-ru.c nls_koi8-u.c nls_sjis.c
nls_tis-620.c nls_utf8.c > .depend
make[4]: *** [fastdep] Error 135
make[4]: Leaving directory `/usr/src/linux-2.4.20/fs/nls'
make[3]: *** [_sfdep_nls] Error 2
make[3]: Leaving directory `/usr/src/linux-2.4.20/fs'
make[2]: *** [fastdep] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.20/fs'
make[1]: *** [_sfdep_fs] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.20'
make: *** [dep-files] Error 2
root@develbox:/usr/src/linux#

att,
Breno

