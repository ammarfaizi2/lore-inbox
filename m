Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274872AbRJRLxI>; Thu, 18 Oct 2001 07:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274920AbRJRLw6>; Thu, 18 Oct 2001 07:52:58 -0400
Received: from noc.easyspace.net ([62.254.202.67]:18704 "EHLO
	noc.easyspace.net") by vger.kernel.org with ESMTP
	id <S274872AbRJRLwp>; Thu, 18 Oct 2001 07:52:45 -0400
Date: Thu, 18 Oct 2001 12:52:39 +0100
From: Sam Vilain <sam@vilain.net>
To: linux-kernel@vger.kernel.org
Subject: ds: no socket drivers loaded! in 2.4.x
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Face: NErb*2NY4\th?$s.!!]_9le_WtWE'b4;dk<5ot)OW2hErS|tE6~D3errlO^fVil?{qe4Lp_m\&Ja!;>%JqlMPd27X|;b!GH'O.,NhF*)e\ln4W}kFL5c`5t'9,(~Bm_&on,0Ze"D>rFJ$Y[U""nR<Y2D<b]&|H_C<eGu?ncl.w'<
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E15uBj5-0006lx-00@hoffman.vilain.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hoffman:/root# modprobe ds 
/lib/modules/2.4.12-scv/kernel/drivers/pcmcia/ds.o: init_module: Operation not permitted
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.4.12-scv/kernel/drivers/pcmcia/ds.o: insmod /lib/modules/2.4.12-scv/kernel/drivers/pcmcia/ds.o failed
/lib/modules/2.4.12-scv/kernel/drivers/pcmcia/ds.o: insmod ds failed
hoffman:/root# dmesg | tail -1
ds: no socket drivers loaded!

This is on a Dell Inspiron 4000 FWIW.  I'm using 2.4.12-ac3, but had
exactly the same problem with plain 2.4.9 and every other 2.4 kernel I've
tried.

I've put my .config, and output from a few other commands at:

http://sam.vilain.net/no-socket/

Any ideas?

Sam.
