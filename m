Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275424AbRJJLfP>; Wed, 10 Oct 2001 07:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275449AbRJJLfE>; Wed, 10 Oct 2001 07:35:04 -0400
Received: from mail.case.pt ([194.65.97.60]:7184 "EHLO case_primary.case.pt")
	by vger.kernel.org with ESMTP id <S275424AbRJJLey>;
	Wed, 10 Oct 2001 07:34:54 -0400
Message-ID: <01C15186.EA371330.rui.ribeiro@case.pt>
From: Rui Ribeiro <rui.ribeiro@case.pt>
Reply-To: "rui.ribeiro@case.pt" <rui.ribeiro@case.pt>
To: "'Cyrus'" <cyrus@linuxmail.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Clock Skew?... kernel compile.....2.4.11...
Date: Wed, 10 Oct 2001 12:27:22 +0100
Organization: Case, S.A.
X-Mailer: Microsoft Internet E-mail/MAPI - 8.0.0.4211
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The same thing happens to me when I have booted a kernel without RTC 
support. (I have a two-set floppy disk for recovery operations w/ a *very* 
simplified kernel).

It got something to do with RTC and timezone adjustments. I still didn't 
discover the full details.

Rui

-----Original Message-----
From:	Cyrus [SMTP:cyrus@linuxmail.org]
Sent:	Quarta-feira, 10 de Outubro de 2001 0:28
To:	linux-kernel@vger.kernel.org
Subject:	Clock Skew?... kernel compile.....2.4.11...

hi all,

i was compiling kernel 2.4.11... on my two machines. my server, which is
an intel p2 233Mhz mmx... went alright without errors....

but my athlon system, 1.2 thunderbird was spewing out this error.

honestly, i've never encountered this one...

Root device is (3, 3)
Boot sector 512 bytes.
Setup is 4640 bytes.
System is 798 kB
make[1]: Leaving directory `/usr/src/linux-2.4.11/arch/i386/boot'
make: warning:  Clock skew detected.  Your build may be incomplete.

real    3m47.334s
user    2m46.510s
sys     0m29.330s


any ideas?... thanks in a lot...


cyrus

--
  Cyrus Santos

Registered Slackware Linux User # 220455
Sydney, Australia

"...the best things in life are free...."




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
