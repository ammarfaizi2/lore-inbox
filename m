Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264946AbSLJVfA>; Tue, 10 Dec 2002 16:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266772AbSLJVfA>; Tue, 10 Dec 2002 16:35:00 -0500
Received: from mailnw.centurytel.net ([209.206.160.237]:13035 "EHLO
	mailnw.centurytel.net") by vger.kernel.org with ESMTP
	id <S264946AbSLJVe6>; Tue, 10 Dec 2002 16:34:58 -0500
Message-ID: <3DF6D088.5060308@centurytel.net>
Date: Tue, 10 Dec 2002 22:43:36 -0700
From: eric lin <fsshl@centurytel.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Holger Waechtler <holger@convergence.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: how do you successful compile or install 2.5.50?
References: <3DF5EC8E.9050603@centurytel.net> <3DF5C40B.5060002@convergence.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Holger Waechtler wrote:

> eric lin wrote:
>
>> Dear Valdis:
>>
>>   I also download from kernel.org 2.5.50, it have error at make 
>> modules or make install
>
>
> Where exactly do you get the error? Please send post the last lines of 
> your compile log to the appropriate mailing list.
>
> linux-dvb for DVB-related stuff and linux-kernel for the general stuff.
>
> Holger
>
>
>
 gcc -Wp,-MD,drivers/char/.mxser.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-Iarch/i386/mach-generic -Iarch/i386/mach-defaults -nostdinc 
-iwithprefix include -DMODULE   -DKBUILD_BASENAME=mxser 
-DKBUILD_MODNAME=mxser   -c -o drivers/char/mxser.o drivers/char/mxser.c
drivers/char/mxser.c:378: redefinition of `__module_name'
drivers/char/mxser.c:332: `__module_name' previously defined here
make[2]: *** [drivers/char/mxser.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2
www:/home/fsshl/linux-2.5.50#

that is 2.5.50 with .50-ac1 patch
  /* I do not know  now where can get 2.5.50 since I got from kernel.org 
the latest is 50 but now is 51 */

sincere Eric
www.linuxspice.com
linux pc for sale

