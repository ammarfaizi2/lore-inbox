Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133091AbRDVAhU>; Sat, 21 Apr 2001 20:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133090AbRDVAhK>; Sat, 21 Apr 2001 20:37:10 -0400
Received: from CPE-61-9-151-92.vic.bigpond.net.au ([61.9.151.92]:54774 "EHLO
	eyal.emu.id.au") by vger.kernel.org with ESMTP id <S133089AbRDVAfl>;
	Sat, 21 Apr 2001 20:35:41 -0400
Message-ID: <3AE22753.702859E7@eyal.emu.id.au>
Date: Sun, 22 Apr 2001 10:35:31 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Linker Error With Kernel 2.4.4pre6 and GCC 2.95.3 (Debian)
In-Reply-To: <20010421161851.A24134@brimstone.ucr.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ruschein@brimstone.ucr.edu wrote:
> 
> Here is what I get under a fairly recent Debian woody:
> 
> /usr/src/kernel/linux-2.4.4-pre6/lib/lib.a(rwsem.o): In function `__rwsem_do_wake':
> rwsem.o(.text+0x2e): undefined reference to `__builtin_expect'
> rwsem.o(.text+0x6f): undefined reference to `__builtin_expect'
> make: *** [vmlinux] Error 1
> bender:/usr/src/kernel/linux-2.4.4-pre6 [root]# gcc --version
> 2.95.3

I get the same error with Debian stable (2.2-r3)

# gcc --version
2.95.2

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
