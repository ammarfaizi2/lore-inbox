Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283252AbRK2Otf>; Thu, 29 Nov 2001 09:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283254AbRK2OtZ>; Thu, 29 Nov 2001 09:49:25 -0500
Received: from jakorasia.nic.fi ([212.38.224.80]:22458 "EHLO jakorasia.nic.fi")
	by vger.kernel.org with ESMTP id <S283252AbRK2OtP>;
	Thu, 29 Nov 2001 09:49:15 -0500
Message-Id: <200111291449.QAA29670@jakorasia.nic.fi>
Content-Type: text/plain; charset=US-ASCII
From: jarmo kettunen <oh1mrr@nic.fi>
To: linux-kernel@vger.kernel.org
Subject: My previous question about iwlib
Date: Thu, 29 Nov 2001 16:49:56 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry,if my previous message was incorrect about iwlib maintaining...
Suppose this example lights more than my words what I want to ask.

gcc -O2 -Wall -DGLIBC_HEADERS  -c iwlib.c
In file included from iwlib.c:11:
iwlib.h:91:8: warning: extra tokens at end of #endif directive
iwlib.h:96:8: warning: extra tokens at end of #endif directive
In file included from iwlib.h:42,
                 from iwlib.c:11:
/usr/include/linux/in.h:25: conflicting types for `IPPROTO_IP'
/usr/include/netinet/in.h:32: previous declaration of `IPPROTO_IP'
/usr/include/linux/in.h:26: conflicting types for `IPPROTO_ICMP'
/usr/include/netinet/in.h:36: previous declaration of `IPPROTO_ICMP'
/usr/include/linux/in.h:27: conflicting types for `IPPROTO_IGMP'
/usr/include/netinet/in.h:38: previous declaration of `IPPROTO_IGMP'
/usr/include/linux/in.h:28: conflicting types for `IPPROTO_IPIP'
/usr/include/netinet/in.h:40: previous declaration of `IPPROTO_IPIP'
/usr/include/linux/in.h:29: conflicting types for `IPPROTO_TCP'
/usr/include/netinet/in.h:42: previous declaration of `IPPROTO_TCP'
/usr/include/linux/in.h:30: conflicting types for `IPPROTO_EGP'
/usr/include/netinet/in.h:44: previous declaration of `IPPROTO_EGP'
/usr/include/linux/in.h:31: conflicting types for `IPPROTO_PUP'
/usr/include/netinet/in.h:46: previous declaration of `IPPROTO_PUP'
/usr/include/linux/in.h:32: conflicting types for `IPPROTO_UDP'
/usr/include/netinet/in.h:48: previous declaration of `IPPROTO_UDP'
/usr/include/linux/in.h:33: conflicting types for `IPPROTO_IDP'
/usr/include/netinet/in.h:50: previous declaration of `IPPROTO_IDP'
/usr/include/linux/in.h:34: conflicting types for `IPPROTO_RSVP'
/usr/include/netinet/in.h:60: previous declaration of `IPPROTO_RSVP'
/usr/include/linux/in.h:35: conflicting types for `IPPROTO_GRE'
/usr/include/netinet/in.h:62: previous declaration of `IPPROTO_GRE'
/usr/include/linux/in.h:37: conflicting types for `IPPROTO_IPV6'
/usr/include/netinet/in.h:54: previous declaration of `IPPROTO_IPV6'
/usr/include/linux/in.h:39: conflicting types for `IPPROTO_PIM'
/usr/include/netinet/in.h:78: previous declaration of `IPPROTO_PIM'
/usr/include/linux/in.h:41: conflicting types for `IPPROTO_ESP'
/usr/include/netinet/in.h:64: previous declaration of `IPPROTO_ESP'
/usr/include/linux/in.h:42: conflicting types for `IPPROTO_AH'
/usr/include/netinet/in.h:66: previous declaration of `IPPROTO_AH'
/usr/include/linux/in.h:43: conflicting types for `IPPROTO_COMP'
/usr/include/netinet/in.h:80: previous declaration of `IPPROTO_COMP'
/usr/include/linux/in.h:45: conflicting types for `IPPROTO_RAW'
/usr/include/netinet/in.h:82: previous declaration of `IPPROTO_RAW'
/usr/include/linux/in.h:47: conflicting types for `IPPROTO_MAX'
/usr/include/netinet/in.h:85: previous declaration of `IPPROTO_MAX'
/usr/include/linux/in.h:51: redefinition of `struct in_addr'
/usr/include/linux/in.h:92: redefinition of `struct ip_mreq'
/usr/include/linux/in.h:98: redefinition of `struct ip_mreqn'
/usr/include/linux/in.h:105: redefinition of `struct in_pktinfo'
/usr/include/linux/in.h:113: redefinition of `struct sockaddr_in'
iwlib.c: In function `iw_sockets_open':
iwlib.c:46: warning: implicit declaration of function `socket'
make: [iwlib.o] Error 1 (ignored)
rm -f libiw.a
ar cru libiw.a iwlib.o
ar: iwlib.o: No such file or directory
make: [libiw.a] Error 1 (ignored)
ranlib libiw.a
ranlib: libiw.a: No such file or directory
make: [libiw.a] Error 9 (ignored)
gcc -O2 -shared -o libiw.so.22 -Wl,-soname,libiw.so.22 -lm -lc iwlib.o
gcc: iwlib.o: No such file or directory

As I have no knowledge of code,asked wireless-tools maintainer what's wrong 
got answer,what I wrote in my previous message.....

So coul someone enlight me what to do....

jarmo
oh1mrr@nic.fi



