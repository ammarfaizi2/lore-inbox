Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293603AbSCSDdh>; Mon, 18 Mar 2002 22:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293604AbSCSDd2>; Mon, 18 Mar 2002 22:33:28 -0500
Received: from relay03.valueweb.net ([216.219.253.237]:29715 "EHLO
	relay03.valueweb.net") by vger.kernel.org with ESMTP
	id <S293603AbSCSDdM>; Mon, 18 Mar 2002 22:33:12 -0500
Message-ID: <3C96B437.A972B15F@opersys.com>
Date: Mon, 18 Mar 2002 22:44:55 -0500
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16-rthal5-TRACE i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] LTT 0.9.5pre6: MIPS, RTAI and many fixes.
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


LTT 0.9.5pre6 is now out. This is the last of the 0.9.5preX series.
I will wait a week or two for feedback on this release and will be
releasing 0.9.5 final with any necessary bugfixes.

LTT now supports 5 architectures: i386, PPC, S/390, SuperH and MIPS.
Still a couple more to go ... Anyone want to port to ia64, ARM or Sparc?

Here's the list of changes since the last release:
1)  Support for MIPS (Thx Takuzo O'Hara, Sony corp.). This port needs some work
    however since many trace statements in the arch/mips directory are commented
    in order not to crash the machine. I don't have a MIPS-based system
    available, but if you've got one please test this and let me know what you get.
2)  Fixed support for RTAI, works with 24.1.8 and 2.4.16 (A great deal of thanks
    to Jörg Hermann from Multilink for his patches and all the new icons.)
    Both trace drawing and cross-platform reading capabilities work fine now and
    should not brake any time soon :)
3)  Build fix => Added -L../LibLTT/ for Visualizer (Thx Klaas Gadeyne, Leuven university)
4)  Enable Solaris build (Thx Frank Rowand, MontaVista)
5)  Missing braces in sys_write and sys_read (Thx Michel Dagenais, Ecole Polytechnique
    de Montréal, and Frank Rowand, MontaVista)
6)  Visualizer and DB bug fixes (Thx Andreas Heppel, SYSGO RT-Solutions)
7)  Kernel s390 bitops fixes (Thx Theresa Halloran, IBM)
8)  Fix kernel compile with no trace support (Thx Vamsi Krishna, IBM)
9)  Update of syscall names (Thx Frank Rowand, MontaVista)
10) Load/unload/trace SMP race condition fix (Thx Corey Minyard, MontaVista)

As always, LTT is available from the project's website at:
http://www.opersys.com/LTT

Have fun,

Karim

===================================================
                 Karim Yaghmour
               karym@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
