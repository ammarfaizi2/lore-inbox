Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135588AbREEXII>; Sat, 5 May 2001 19:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135585AbREEXH7>; Sat, 5 May 2001 19:07:59 -0400
Received: from pc-62-30-76-3-az.blueyonder.co.uk ([62.30.76.3]:54788 "EHLO
	mnemosyne.j-harris.dircon.co.uk") by vger.kernel.org with ESMTP
	id <S135580AbREEXHt>; Sat, 5 May 2001 19:07:49 -0400
Date: Sun, 6 May 2001 00:08:07 +0100 (GMT Daylight Time)
From: Jamie Harris <jamie.harris@uwe.ac.uk>
To: <linux-kernel@vger.kernel.org>, <linux-admin@vger.kernel.org>,
        Bristol LUG <bristol@lists.lug.org.uk>
cc: <smoshea@hotmail.com>, <siymann@yahoo.com>
Subject: Solved: Kernel NULL pointer, over my head...
Message-ID: <Pine.WNT.4.33.0105060004290.-1841329-100000@proteus.j-harris.dircon.co.uk>
X-X-Sender: j-harris@mercury.uwe.ac.uk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to everyone who help me solve this one... As suspected by a few of
you it turned out to be duff CPU - you mean Linux can't work around that
yet!! ;)

Thanks again.

Jamie...

---------- Forwarded message ----------
Date: Tue, 1 May 2001 05:46:02 +0100 (GMT Daylight Time)
From: Jamie Harris <jamie.harris@uwe.ac.uk>
To: linux-kernel@vger.kernel.org, Bristol LUG <bristol@lists.lug.org.uk>,
     linux-admin@vger.kernel.org
Subject: Kernel NULL pointer, over my head...

Morning all,

Sorry for the big cross post but I don't have the first clue about where
to send this one.  I get this from my stock 2.2.18 kernel in
/var/log/syslog:

May  1 05:27:36 mnemosyne kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
May  1 05:27:36 mnemosyne kernel: current->tss.cr3 = 00362000, %cr3 =
00362000
May  1 05:27:36 mnemosyne kernel: *pde = 00000000
May  1 05:29:36 mnemosyne kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
May  1 05:29:36 mnemosyne kernel: current->tss.cr3 = 036dc000, %cr3 =
036dc000
May  1 05:29:36 mnemosyne kernel: *pde = 00000000
May  1 05:30:28 mnemosyne kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
May  1 05:30:28 mnemosyne kernel: current->tss.cr3 = 00ca7000, %cr3 =
00ca7000
May  1 05:30:28 mnemosyne kernel: *pde = 00000000


This time it seemed to be caused by running tar on a file, but I've
noticed a similar error in the past but they've never made anything fall
over.  The tar process appeared to die but then again so did the telnet
session so I don't know in what order they went down.  I tried 3 times
just to check it wasn't a fluke...  What other details would be useful??

Cheers Jamie...

PS I'm not on the linux-kernel list so please post to me directly...


=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 ***    Slowly and surely the UNIX crept up on the Nintendo user...    ***
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GCS/ED d-(++) s:+ a- C+++>++++$ U+++>$ P++++ L+++>+++++ E+(---) W++ N o?
K? w(++++) O- M V? PS PE? Y PGP- t+ 5 X- R- tv- b++ DI++ D+++ G e++ h*
r++>+++ y+++
------END GEEK CODE BLOCK------


