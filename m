Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSHNKaH>; Wed, 14 Aug 2002 06:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316339AbSHNKaH>; Wed, 14 Aug 2002 06:30:07 -0400
Received: from pa147.antoniuk.sdi.tpnet.pl ([213.25.59.147]:14069 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S315374AbSHNKaG>; Wed, 14 Aug 2002 06:30:06 -0400
Date: Wed, 14 Aug 2002 12:35:44 +0200
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jpopl@interia.pl>
To: linux-kernel@vger.kernel.org
Subject: can't use 2.4 on my 486 server
Message-ID: <20020814103544.GA1018@darkwood.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use 2.4 kernel for a long time on my workstations, but can't use it on old
486 server with 16MB RAM. 2.2 works there without problems (for a long time).
But few hours after running 2.4.19 server is unreachable. When I connect
monitor/keyboard and start it again I see fsck starting then:

Unable to handle kernel paging request at virtual address db9910c0

(...)

Kernel panic: aiee, killing interrupt handler.

I've tried 2.4.18 and earlier versions before. Always same problem. There is
fsck 1.22 and glibc-2.2.3 there - standard Slackware 8.0 distribution which
works on other computers.

What should I check? What should i try to change there? What more info can I
give you (is it important to rewrite full kernel message with all registers?) ?

jp@darkstar:~$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 4
model           : 3
model name      : 486 DX/2
stepping        : 5
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme
bogomips        : 33.28

-- 
http://decopter.sf.net - free unrealistic helicopter simulator
