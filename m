Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292935AbSB0WGD>; Wed, 27 Feb 2002 17:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292989AbSB0WFg>; Wed, 27 Feb 2002 17:05:36 -0500
Received: from [198.16.16.39] ([198.16.16.39]:47675 "EHLO carthage")
	by vger.kernel.org with ESMTP id <S292991AbSB0WFU>;
	Wed, 27 Feb 2002 17:05:20 -0500
Date: Wed, 27 Feb 2002 16:01:38 -0600
From: James Curbo <jcurbo@acm.org>
To: linux-kernel@vger.kernel.org
Subject: (2.5.5-dj2) still getting .text.exit linker errors
Message-ID: <20020227220138.GA5644@carthage>
Reply-To: James Curbo <jcurbo@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Debian GNU/Linux
Organization: Henderson State University, Arkadelphia, AR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[note: I am not subscribed, please cc: me in replies]

When compiling 2.5.5-dj2, I am still getting a .text.exit linker error:

drivers/net/net.o(.data+0x1274): undefined reference to `local symbols 
in discarded section .text.exit'

I am using Debian unstable, binutils 2.11.93.0.2:

ii  binutils       2.11.93.0.2-2

I can get it to link if I follow the directions that the Debian
maintainer has been giving out (deleting the .text.exit line from
vmlinux.lds) but that isn't the right solution, and I don't have the
abilities to actually fix it. My ver_linux output is appeneded at the
end. Thanks in advance.

James

Linux carthage 2.5.5-dj2 #1 Wed Feb 27 01:08:00 CST 2002 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.13
e2fsprogs              1.26
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         emu10k1 ac97_codec sound

-- 
James Curbo <jcurbo@acm.org> <jc108788@rc.hsu.edu>
Undergraduate Computer Science, Henderson State University
PGP Keys at <http://reddie.henderson.edu/~curboj/>
Public Keys: PGP - 1024/0x76E2061B GNUPG - 1024D/0x3EEA7288
