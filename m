Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbTEIGik (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 02:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbTEIGik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 02:38:40 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:779 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262298AbTEIGij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 02:38:39 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Kang Kai <kkai@bit.edu.cn>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: failed to  "make xconfig" after patching patch-2.4.21-rc2.bz2
Date: Fri, 9 May 2003 08:50:58 +0200
User-Agent: KMail/1.5.1
References: <200305091439.15319.kkai@bit.edu.cn>
In-Reply-To: <200305091439.15319.kkai@bit.edu.cn>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305090850.41210.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 May 2003 08:39, Kang Kai wrote:

Hi Kang,

> I just patched a new fresh linux-2.4.20 with patch-2.4.21-rc2.bz2.
> But  I failed to  "make xconfig", the error is:
> rm -f include/asm
> ( cd include ; ln -sf asm-i386 asm)
> make -C scripts kconfig.tk
> make[1]: Entering directory `/usr/src/linux-2.4.20/scripts'
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkparse.o
> tkparse.cgcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o
> tkcond.o tkcond.c
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkgen.o
> tkgen.c gcc -o tkparse tkparse.o tkcond.o tkgen.o
> cat header.tk >> ./kconfig.tk
> ./tkparse < ../arch/i386/config.in >> kconfig.tk
> drivers/ide/Config.in: 46: can't handle dep_bool/dep_mbool/dep_tristate
> condition
> make[1]: *** [kconfig.tk] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.4.20/scripts'
> make: *** [xconfig] Error 2
search the archives. A fix for this was posted, at least to my knowledge, 
about 10 times the past weeks.

ciao, Marc
