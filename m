Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbTKQR6b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 12:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbTKQR6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 12:58:31 -0500
Received: from alpha.zarz.agh.edu.pl ([149.156.122.231]:36102 "EHLO
	alpha.zarz.agh.edu.pl") by vger.kernel.org with ESMTP
	id S263614AbTKQR6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 12:58:30 -0500
Date: Mon, 17 Nov 2003 20:00:50 +0100 (CET)
From: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: HOWTO build modules in 2.6.0 ...
Message-ID: <Pine.LNX.4.58L.0311171939150.25906@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

How can I build kernel modele from other package without root, or copying 
all from /usr/scr/linux/ ??
When I try build kernel module from user i got error,

[...]
make[1]: Leaving directory `/users/cieciwa/rpm/BUILD/eagle-1.0.4/driver'
/usr/bin/make -C /usr/src/linux SUBDIRS=`pwd` modules;
make[1]: Entering directory `/usr/src/linux-2.6.0'
  HOSTCC  scripts/fixdep
cc1: Permission denied: opening dependency file scripts/.fixdep.d
make[2]: *** [scripts/fixdep] Error 1
make[1]: *** [scripts] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.0'
make: *** [adiusbadsl.o] Error 2
make: Leaving directory `/users/cieciwa/rpm/BUILD/eagle-1.0.4/driver'

How can I solve this problem ??

Thanx,
					Sas.
-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}
