Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264017AbRFHPrF>; Fri, 8 Jun 2001 11:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262168AbRFHPqy>; Fri, 8 Jun 2001 11:46:54 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:41743 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S264017AbRFHPqs>; Fri, 8 Jun 2001 11:46:48 -0400
Subject: Unresolved symbols in 2.4.6-pre1
From: Dietmar Kling <dietmar.kling@sam-net.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 08 Jun 2001 17:46:42 +0200
Message-Id: <992015202.32691.0.camel@minitiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A make modules_install gives:

depmod: *** Unresolved symbols in
/lib/modules/2.4.6-pre1/kernel/drivers/input/keybdev.o
depmod:         tasklet_schedule
depmod: *** Unresolved symbols in
/lib/modules/2.4.6-pre1/kernel/drivers/isdn/hisax/hisax.o
depmod:         tasklet_hi_schedule
depmod: *** Unresolved symbols in
/lib/modules/2.4.6-pre1/kernel/drivers/isdn/isdn.o
depmod:         tasklet_hi_schedule
depmod:         do_softirq
depmod: *** Unresolved symbols in
/lib/modules/2.4.6-pre1/kernel/drivers/net/ppp_async.o
depmod:         do_softirq
depmod: *** Unresolved symbols in
/lib/modules/2.4.6-pre1/kernel/drivers/net/ppp_generic.o
depmod:         do_softirq
depmod: *** Unresolved symbols in
/lib/modules/2.4.6-pre1/kernel/drivers/net/ppp_synctty.o
depmod:         do_softirq
depmod: *** Unresolved symbols in
/lib/modules/2.4.6-pre1/kernel/drivers/net/pppoe.o
depmod:         do_softirq
depmod: *** Unresolved symbols in
/lib/modules/2.4.6-pre1/kernel/drivers/net/pppox.o
depmod:         do_softirq

