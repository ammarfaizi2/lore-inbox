Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265547AbSKABWC>; Thu, 31 Oct 2002 20:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbSKABVm>; Thu, 31 Oct 2002 20:21:42 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:3271 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S265568AbSKABU2>; Thu, 31 Oct 2002 20:20:28 -0500
Message-ID: <3DC1D85A.2020102@attbi.com>
Date: Thu, 31 Oct 2002 17:26:50 -0800
From: Miles Lane <miles.lane@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021022
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Skip Ford <skip.ford@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 ipmr.c syntax error
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Skip, I tried your patch from:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103604415923099&w=2

I got the following error after applying it:

  gcc -Wp,-MD,net/ipv4/.ipmr.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon -Iarch/i386/mach-generic -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=ipmr   -c -o net/ipv4/ipmr.o net/ipv4/ipmr.c
net/ipv4/ipmr.c: In function `ipmr_queue_xmit':
net/ipv4/ipmr.c:1170: incompatible type for argument 1 of `dst_pmtu'
make[2]: *** [net/ipv4/ipmr.o] Error 1
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2



