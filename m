Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263232AbSJJEdB>; Thu, 10 Oct 2002 00:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263241AbSJJEdB>; Thu, 10 Oct 2002 00:33:01 -0400
Received: from epic7.Stanford.EDU ([171.64.15.40]:47541 "EHLO
	epic7.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S263232AbSJJEdA>; Thu, 10 Oct 2002 00:33:00 -0400
Date: Wed, 9 Oct 2002 21:38:38 -0700 (PDT)
From: Vikram <vvikram@stanford.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.5.41 : ipv6 compile failure?
Message-ID: <Pine.GSO.4.44.0210092136040.725-100000@epic7.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


tried to compile 2.5.41 with ipv6 support , i get the following build
failure:

<snip>

 gcc -Wp,-MD,net/ipv6/.addrconf.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DKBUILD_BASENAME=addrconf   -c -o net/ipv6/addrconf.o net/ipv6/addrconf.c
net/ipv6/addrconf.c: In function `ipv6_addr_type':
net/ipv6/addrconf.c:155: case label does not reduce to an integer constant
net/ipv6/addrconf.c:159: case label does not reduce to an integer constant
net/ipv6/addrconf.c:163: case label does not reduce to an integer constant
net/ipv6/addrconf.c:156: warning: unreachable code at beginning of switch
statement
make[2]: *** [net/ipv6/addrconf.o] Error 1
make[1]: *** [net/ipv6] Error 2
make: *** [net] Error 2

</snip>

apologies if this is redundant.



			Vikram


