Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265674AbTFSBDx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 21:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265675AbTFSBDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 21:03:53 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:44705 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id S265674AbTFSBDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 21:03:51 -0400
Message-ID: <3EF10F3E.1090308@cern.ch>
Date: Thu, 19 Jun 2003 03:17:50 +0200
From: Riccardo-Maria Bianchi <Riccardo-Maria.Bianchi@cern.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: glibc compiling with kernel 2.5.70-bk17
X-Priority: 1 (highest)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Good morning,

I'm trying to compiling several version of the glibc but always during 
the "make" I obtain these errors:



------------------------------------------ cut 
-----------------------------------------------------------------------------------------------------

In file included from 
/lib/modules/2.5.70-bk15/build/include/linux/sysctl.h:29,
                 from ../sysdeps/unix/sysv/linux/sys/sysctl.h:28,
                 from ../include/sys/sysctl.h:2,
                 from ../sysdeps/unix/sysv/linux/dl-osinfo.h:21,
                 from ../sysdeps/unix/sysv/linux/init-first.c:32:
/lib/modules/2.5.70-bk15/build/include/linux/list.h:521:2: warning: 
#warning "don't include kernel headers in userspace"
In file included from ../sysdeps/unix/sysv/linux/sys/sysctl.h:28,
                 from ../include/sys/sysctl.h:2,
                 from ../sysdeps/unix/sysv/linux/dl-osinfo.h:21,
                 from ../sysdeps/unix/sysv/linux/init-first.c:32:
/lib/modules/2.5.70-bk15/build/include/linux/sysctl.h:39: warning: no 
semicolon at end of struct or union
/lib/modules/2.5.70-bk15/build/include/linux/sysctl.h:39: error: parse 
error before '*' token
/lib/modules/2.5.70-bk15/build/include/linux/sysctl.h:41: error: parse 
error before '*' token
/lib/modules/2.5.70-bk15/build/include/linux/sysctl.h:41: warning: type 
defaults to `int' in declaration of `oldval'
/lib/modules/2.5.70-bk15/build/include/linux/sysctl.h:41: warning: data 
definition has no type or storage class
/lib/modules/2.5.70-bk15/build/include/linux/sysctl.h:42: error: parse 
error before '*' token
/lib/modules/2.5.70-bk15/build/include/linux/sysctl.h:42: warning: type 
defaults to `int' in declaration of `oldlenp'
/lib/modules/2.5.70-bk15/build/include/linux/sysctl.h:42: warning: data 
definition has no type or storage class
/lib/modules/2.5.70-bk15/build/include/linux/sysctl.h:43: error: parse 
error before '*' token
/lib/modules/2.5.70-bk15/build/include/linux/sysctl.h:43: warning: type 
defaults to `int' in declaration of `newval'
/lib/modules/2.5.70-bk15/build/include/linux/sysctl.h:43: warning: data 
definition has no type or storage class
/lib/modules/2.5.70-bk15/build/include/linux/sysctl.h:46: error: parse 
error before '}' token
make[2]: *** [/home/nptl/glibc_2_3_1/build/csu/init-first.o] Error 1
make[2]: Leaving directory `/home/nptl/glibc_2_3_1/glibc-2.3.1/csu'
make[1]: *** [csu/subdir_lib] Error 2
make[1]: Leaving directory `/home/nptl/glibc_2_3_1/glibc-2.3.1'
make: *** [all] Error 2

---------------------------------------------------- cut 
-------------------------------------------------------------------------------------

I have:
2.5.70-bk17   (even if the 2.5.70-bk15 is shown on the path)
gcc 3.3
binutils 2.13.92

Someone have an idea? :)

Thanks,

  Riccardo-Maria Bianchi



