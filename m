Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317632AbSGFLn3>; Sat, 6 Jul 2002 07:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317633AbSGFLn2>; Sat, 6 Jul 2002 07:43:28 -0400
Received: from p50839BA9.dip.t-dialin.net ([80.131.155.169]:55646 "EHLO
	pc1.geisel.info") by vger.kernel.org with ESMTP id <S317632AbSGFLn1> convert rfc822-to-8bit;
	Sat, 6 Jul 2002 07:43:27 -0400
Date: Sat, 6 Jul 2002 13:45:58 +0200 (CEST)
From: Dominik Geisel <devnull@geisel.info>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.5.25 compile error
Message-ID: <Pine.LNX.4.44.0207061345080.4005-100000@pc1.geisel.info>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on 'make dep' with 2.5.25 I get the following error:

-----------------------------------------------------------------------------
make[1]: Wechsel in das Verzeichnis Verzeichnis »/usr/src/linux«
make[2]: Wechsel in das Verzeichnis Verzeichnis »/usr/src/linux/scripts«
  gcc -Wp,-MD,./.split-include.d -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer   -o split-include split-include.c
In file included from /usr/include/linux/errno.h:4,
                 from /usr/include/bits/errno.h:25,
                 from /usr/include/errno.h:36,
                 from split-include.c:26:
/usr/include/asm/errno.h:4:31: asm-generic/errno.h: No such file or 
directory
make[2]: *** [split-include] Fehler 1
make[2]: Verlassen des Verzeichnisses Verzeichnis »/usr/src/linux/scripts«
make[1]: *** [scripts] Fehler 2
make[1]: Verlassen des Verzeichnisses Verzeichnis »/usr/src/linux«
make: *** [.hdepend] Fehler 2
-----------------------------------------------------------------------------

Any ideas?

Greetings,
Dominik Geisel

-- 
We may not imagine how our lives could be more frustrating and
complex--but Congress can.
-Cullen Hightower (contributed by Chris Johnston)
907D F135 0EF8 5A4D 633B  805D 25E7 478B 1322 4688

