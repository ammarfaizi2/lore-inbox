Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbTHTTGd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 15:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbTHTTGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 15:06:33 -0400
Received: from c2mailgwalt.mailcentro.com ([207.183.238.112]:30360 "EHLO
	c2mailgwalt.mailcentro.com") by vger.kernel.org with ESMTP
	id S262159AbTHTTGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 15:06:31 -0400
X-Version: Mailcentro(english)
X-SenderIP: 80.58.9.46
X-SenderID: 7831070
From: "Jose Luis Alarcon Sanchez" <jlalarcon@chevy.zzn.com>
Message-Id: <E96C2F4A05ED921428A526DA41374385@jlalarcon.chevy.zzn.com>
Date: Wed, 20 Aug 2003 21:06:25 +0200
X-Priority: Normal
Content-Type: text/plain; charset=iso-8859-1
To: linuxmodule@altern.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 module compilation
X-Mailer: Web Based Pronto
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---- Begin Original Message ----
 From: <linuxmodule@altern.org>
Sent: Wed, 20 Aug 2003 18:39:19 +0200 (CEST)
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3 module compilation

I am trying to compile a module on 2.6.0-test3 kernel. The makefile i
am using is a pretty normal one : 

CFLAGS = -D__KERNEL__ -DMODULE -I/usr/src/linux-2.6.0-test3/include -O
dummy.o: dummy.c

The module i am trying to compile is taken from the kernel itself
(dummy network device driver). The
compilation works flawlessly but when i try to insert the module i get
: invalid module format.
What am i doing wrong because i have modutils and module-init and both
work, since the same module (dummy)
compiled with the kernel itself can be inserted and removed without
the previous error message.
Is there something i should know about the compilation process ? The
kernel-compiled module (dummy.ko) has
about 10 Kbytes and dummy.ko compiled by me has only 2 Kbytes :(

Thank you in advance
Snowdog
---- End Original Message ----

  Try to give a look to this "Linux Weekly News" article:

     http://lwn.net/Articles/21823

  Good luck.

  Regards.

  Jose.


http://linuxespana.scripterz.org

FreeBSD RELEASE 4.8.
Mandrake Linux 9.1 Kernel 2.6.0-test3 XFS.
Registered BSD User 51101.
Registered Linux User #213309.
Memories..... You are talking about memories. 
Rick Deckard. Blade Runner.


Get your Free E-mail at http://chevy.zzn.com
___________________________________________________________
Get your own Web-based E-mail Service at http://www.zzn.com
