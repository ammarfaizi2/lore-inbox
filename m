Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270319AbRH3IeA>; Thu, 30 Aug 2001 04:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271068AbRH3Idu>; Thu, 30 Aug 2001 04:33:50 -0400
Received: from linuxqa.com ([212.143.78.26]:6605 "EHLO alegator.linuxqa.com")
	by vger.kernel.org with ESMTP id <S270319AbRH3Idf>;
	Thu, 30 Aug 2001 04:33:35 -0400
Message-ID: <3B8DFA63.86E13099@aduva.com>
Date: Thu, 30 Aug 2001 11:33:39 +0300
From: Alexander Gavrilov <alegator@aduva.com>
Reply-To: alegator@aduva.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel compile problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to compile kernel 2.2.16-20

with kgcc :

kgcc-1.1.2-40


and i getting those errors :


make[1]: Entering directory `/usr/src/linux-2.2.16/arch/i386/boot'
kgcc -D__KERNEL__ -I/usr/src/linux/include -E -D__BIG_KERNEL__
-traditional -DSVGA_MODE=NORMAL_VGA  bootsect.S -o bbootsect.s
as86 -0 -a -o bbootsect.o bbootsect.s
make[1]: as86: Command not found
make[1]: *** [bbootsect.o] Error 127
make[1]: Leaving directory `/usr/src/linux-2.2.16/arch/i386/boot'
make: *** [bzImage] Error 2


~
~



