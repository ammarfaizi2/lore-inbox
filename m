Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWDFJVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWDFJVr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 05:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWDFJVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 05:21:47 -0400
Received: from pproxy.gmail.com ([64.233.166.183]:11543 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932161AbWDFJVq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 05:21:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aWDwTQqjQXSdgiNw6my4HWfe+dO5OFYWGT6Y+L5ESt6RBJgci914z3kIuDyBLRSTVOM/+kOqeLUEKPpg3/VoNbKs3pRjA0KxdZoHm6ub/MWumHkoT3K6mGyNBe5C4FI073AAWaAm6e1y7mCXuZ66mjPAh9O4I+FaG/MXK5gpF9Q=
Message-ID: <4d8e3fd30604060221i1d49cf2brd5fd786b6ce75822@mail.gmail.com>
Date: Thu, 6 Apr 2006 11:21:46 +0200
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: problem compiling 2.6.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
a friend of mine got this error compiling 2.6.16.1 and we don't know
what's wrong:

uno:/usr/src/linux-2.6.16.1#   make O=/home/dan/build/kernel menuconfig
 HOSTCC  scripts/basic/fixdep
In file included from /usr/include/bits/posix1_lim.h:130,
                from /usr/include/limits.h:144,
                from /usr/lib/gcc-lib/i486-linux/3.3.5/include/limits.h:122,
                from /usr/lib/gcc-lib/i486-linux/3.3.5/include/syslimits.h:7,
                from /usr/lib/gcc-lib/i486-linux/3.3.5/include/limits.h:11,
                from /usr/src/linux-2.6.16.1/scripts/basic/fixdep.c:113:
/usr/include/bits/local_lim.h:36:26: linux/limits.h: No such file or directory
In file included from /usr/include/sys/socket.h:35,
                from /usr/include/netinet/in.h:24,
                from /usr/include/arpa/inet.h:23,
                from /usr/src/linux-2.6.16.1/scripts/basic/fixdep.c:115:
/usr/include/bits/socket.h:305:24: asm/socket.h: No such file or directory
/usr/src/linux-2.6.16.1/scripts/basic/fixdep.c: In function `use_config':
/usr/src/linux-2.6.16.1/scripts/basic/fixdep.c:214: error: `PATH_MAX'
undeclared (first use in this function)
/usr/src/linux-2.6.16.1/scripts/basic/fixdep.c:214: error: (Each
undeclared identifier is reported only once
/usr/src/linux-2.6.16.1/scripts/basic/fixdep.c:214: error: for each
function it appears in.)
/usr/src/linux-2.6.16.1/scripts/basic/fixdep.c:214: warning: unused variable `s'
/usr/src/linux-2.6.16.1/scripts/basic/fixdep.c: In function `parse_dep_file':
/usr/src/linux-2.6.16.1/scripts/basic/fixdep.c:310: error: `PATH_MAX'
undeclared (first use in this function)
/usr/src/linux-2.6.16.1/scripts/basic/fixdep.c:310: warning: unused variable `s'
make[2]: *** [scripts/basic/fixdep] Error 1
make[1]: *** [scripts_basic] Error 2
make: *** [menuconfig] Error 2
uno:/usr/src/linux-2.6.16.1#

Any hint?


--
Paolo
http://paolociarrocchi.googlepages.com
