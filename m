Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286783AbRLVNrc>; Sat, 22 Dec 2001 08:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286784AbRLVNrT>; Sat, 22 Dec 2001 08:47:19 -0500
Received: from f154.law8.hotmail.com ([216.33.241.154]:57101 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S286783AbRLVNrP>;
	Sat, 22 Dec 2001 08:47:15 -0500
X-Originating-IP: [24.45.107.83]
From: "se d" <seandarcy@hotmail.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 build fails at network.o
Date: Sat, 22 Dec 2001 08:47:09 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F154ScHLk1PVlhDq91m0000a4b9@hotmail.com>
X-OriginalArrivalTime: 22 Dec 2001 13:47:10.0059 (UTC) FILETIME=[271503B0:01C18AEF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes it is. But note the "defined but not used" warning. FWIW, I'm using 
gcc-3.1-0.10.


make[3]: Entering directory `/opt/kernel/linux-2.4.17/net/sunrpc'
gcc -D__KERNEL__ -I/opt/kernel/linux-2.4.17/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686    -c -o clnt.o clnt.c
/opt/kernel/linux-2.4.17/include/linux/sunrpc/xprt.h:205: warning: 
`rpciod_tcp_dispatcher' defined but not used
gcc -D__KERNEL__ -I/opt/kernel/linux-2.4.17/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686    -c -o xprt.o xprt.c
In file included from /opt/kernel/linux-2.4.17/include/net/checksum.h:33,
                 from xprt.c:64:
/opt/kernel/linux-2.4.17/include/asm/checksum.h:72:30: warning: multi-line 
string literals are deprecated
/opt/kernel/linux-2.4.17/include/asm/checksum.h:105:17: warning: multi-line 
string literals are deprecated
/opt/kernel/linux-2.4.17/include/asm/checksum.h:121:13: warning: multi-line 
string literals are deprecated
/opt/kernel/linux-2.4.17/include/asm/checksum.h:161:17: warning: multi-line 
string literals are deprecated
/opt/kernel/linux-2.4.17/include/linux/sunrpc/xprt.h:205: warning: 
`rpciod_tcp_dispatcher' defined but not used
................

>From: "David S. Miller" <davem@redhat.com>
>To: seandarcy@hotmail.com
>CC: linux-kernel@vger.kernel.org
>Subject: Re: 2.4.17 build fails at network.o
>Date: Fri, 21 Dec 2001 20:52:14 -0800 (PST)
....................................
>
>Is it building net/sunrpc/xprt.o at all?
>-





_________________________________________________________________
Chat with friends online, try MSN Messenger: http://messenger.msn.com

