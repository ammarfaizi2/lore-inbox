Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273235AbRISLDS>; Wed, 19 Sep 2001 07:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274031AbRISLDI>; Wed, 19 Sep 2001 07:03:08 -0400
Received: from gateway-2.hyperlink.com ([213.52.152.2]:51986 "EHLO
	core-gateway-1.hyperlink.com") by vger.kernel.org with ESMTP
	id <S273235AbRISLC7>; Wed, 19 Sep 2001 07:02:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Martin Brooks <martin@jtrix.com>
Reply-To: martin@jtrix.com
Organization: Jtrix Ltd 
To: linux-kernel@vger.kernel.org
Subject: 2.4.10pre11 build problem
Date: Wed, 19 Sep 2001 12:03:22 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15jf8d-0002Pr-00@obelix.intranet.hyperlink.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I get this error:

mm/mm.o(.text+0x8202): undefined reference to `__builtin_expect'
mm/mm.o(.text+0x821f): undefined reference to `__builtin_expect'
mm/mm.o(.text+0x8272): undefined reference to `__builtin_expect'
mm/mm.o: In function `kmalloc':
mm/mm.o(.text+0x8332): undefined reference to `__builtin_expect'
mm/mm.o(.text+0x834f): undefined reference to `__builtin_expect'
mm/mm.o(.text+0x83a2): more undefined references to `__builtin_expect' follow
make: *** [vmlinux] Error 1


unhygienix:/usr/src/linux# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20010902 (Debian prerelease)

I'm not on the list, please CC any reply.

Regards
-- 

Martin A. Brooks,  Systems Administrator
------------------------------------------------
Jtrix Ltd		t: +44 207 395 4990
57-59 Neal Street	f: +44 207 395 4991
Covent Garden		e: martin@jtrix.org
London WC2H 9PJ		w: http://www.jtrix.org

Running Windows: while (problem){ reboot; last if
Upgrade||ServicePack||MassivelyPublicisedExploit;} restart;
