Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319606AbSIHNYY>; Sun, 8 Sep 2002 09:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319607AbSIHNYY>; Sun, 8 Sep 2002 09:24:24 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:8576 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S319606AbSIHNYX>; Sun, 8 Sep 2002 09:24:23 -0400
Date: Sun, 08 Sep 2002 15:37:55 +0200
From: DervishD <raul@pleyades.net>
Organization: Pleyades
Reply-To: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: setitimer, sleep and SIGALRM
Message-ID: <3D7B52B3.mail70M1RR1QI@pleyades.net>
User-Agent: nail 9.31 6/18/02
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Thomas :))

    AFAIK, 'sleep()' is a libc function, and if you use GNU libc, it
doesn't make use of SIGALRM, so it is safe to use 'setitimer()' and
'sleep()' at the same time on a program.

    Moreover, 'setitimer()' is too a libc function to my knowledge (I
may be wrong here, so please don't hit me XDD).

    Raúl
