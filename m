Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136334AbRDWCB1>; Sun, 22 Apr 2001 22:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136335AbRDWCBR>; Sun, 22 Apr 2001 22:01:17 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:64523 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S136334AbRDWCBD>; Sun, 22 Apr 2001 22:01:03 -0400
From: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Message-Id: <200104222138.XAA00666@kufel.dom>
Subject: Re: Problem with "su -" and kernels 2.4.3-ac11 and higher
To: kufel!mclure.org!manuel@green.mif.pg.gda.pl (Manuel McLure)
Date: Sun, 22 Apr 2001 23:38:55 +0200 (CEST)
Cc: kufel!vger.kernel.org!linux-kernel@green.mif.pg.gda.pl
In-Reply-To: <20010422102234.A1093@ulthar.internal.mclure.org> from "Manuel McLure" at Apr 22, 2001 10:22:34 AM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I'm having a problem with "su -" on ac11/ac12. ac5 doesn't show the
> problem.
> The problem is easy to reproduce - go to a console, log in as root, do an
> "su -" (this will succeed) and then another "su -". The second "su -"
> should hang - ps shows it started bash and that the bash process is
> sleeping. You need to "kill -9" the bash to get your prompt back.

No problem here.

P233MMX

# uname -a
Linux kufel 2.4.3-ac12 #2 nie kwi 22 15:32:51 CEST 2001 i586 unknown

# ls -l /lib/libc-*
-rwxr-xr-x   1 root     root      1060168 Nov 19 11:17 /lib/libc-2.1.3.so

# gcc --version
egcs-2.91.66
(kernel with the fix by Niels Kristian Bech Jensen <nkbj@image.dk>)

# su --version
su (GNU sh-utils) 2.0

Maybe it is RH7 specyfic ? Or you have some compiler / hardware problem ?

Andrzej

