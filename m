Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267080AbSLQXTu>; Tue, 17 Dec 2002 18:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbSLQXSn>; Tue, 17 Dec 2002 18:18:43 -0500
Received: from mailnw.centurytel.net ([209.206.160.237]:8905 "EHLO
	mailnw.centurytel.net") by vger.kernel.org with ESMTP
	id <S267050AbSLQXRQ>; Tue, 17 Dec 2002 18:17:16 -0500
Message-ID: <3E00231C.8020702@centurytel.net>
Date: Wed, 18 Dec 2002 00:26:20 -0700
From: eric lin <fsshl@centurytel.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bob Miller <rem@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.52 compile error
References: <3E058049@zathras> <20021217211618.GB1069@doc.pdx.osdl.net> <3E001825.7080709@centurytel.net> <20021217225428.GC1069@doc.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in the Input device suppoort
I did not see Config_inout in make menuconfig, so I suppose is first 
item(if I am wrong please notify me)

them make dep, meke clean, make modules
then it terminate some other error

  gcc -Wp,-MD,fs/intermezzo/.inode.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic 
-fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE 
-DKBUILD_BASENAME=inode -DKBUILD_MODNAME=intermezzo   -c -o 
fs/intermezzo/inode.o fs/intermezzo/inode.c
make[2]: *** No rule to make target `fs/intermezzo/io_daemon.s', needed 
by `fs/intermezzo/io_daemon.o'.  Stop.
make[1]: *** [fs/intermezzo] Error 2
make: *** [fs] Error 2

please help


>>>At your finger tips ;-).  Turn on CONFIG_INPUT via "Input device support"
>>>off the main page.
>>
>>I did not know what is that mean (off the man page)?
>>
>>Is that at menuconfig
>>or
>>should modify any source code?
>>
> 
> Yes it is at off the first page of "make menuconfig".
> 


-- 
Sincere Eric
www.linuxspice.com
linux pc for sale

