Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276255AbRJPNjF>; Tue, 16 Oct 2001 09:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276249AbRJPNiz>; Tue, 16 Oct 2001 09:38:55 -0400
Received: from [212.162.12.2] ([212.162.12.2]:55187 "EHLO d101.x-mailer.de")
	by vger.kernel.org with ESMTP id <S276247AbRJPNiq>;
	Tue, 16 Oct 2001 09:38:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gietl <a.gietl@e-admin.de>
To: linux-kernel@vger.kernel.org
Subject: tyan K7 thunder
Date: Tue, 16 Oct 2001 15:39:04 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15tUQp-0000h3-00@d101.x-mailer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

First every thing was just fine with our new tyan k7 thunder server and we 
did some load testing and the machine ran fine for 4 weeks. But after we 
started to use it in production we had major stability problems with that new 
Dual Athlon 1200 machine. we found tons of mails in this mailling list about 
this configuration crashing. We tried to stabilize the SMP-kernel (v.2.4.9) 
for 4 days w/o luck. We played around with the bios and especially the use 
pci table in MP table switch gave us a lot more stability but the machine 
still keeped on crashing every few hours with a kernel panic:

kernel panic aiee, killing interrupt handler
in interrupt handler - not syncing'

We tried noapic, and all the things that were recommended. We also read that 
Alan Cox thinks that some of these MBs simply are kind of damaged.

Right now we are running this machine with v2.4.12 uniprocessor kernel and it 
seems to be stable. What i wanna know is whether there are some improvements 
in the support for this mainboard in the kernel from 2.4.9 to 2.4.12 so we 
could risk another try with the SMP kernel.

thank you for you help

andreas

P.S.: The tyan support (after 5 days we were frustrated enough to call them 
up) said the don't support Linux, and their boards are just certified for 
Windows. But of course this is not alternative for us....
-- 
e-admin internet gmbh
Andreas Gietl
Roter-Brach-Weg 124a
tel +49 941 3810884
fax +49 941 3810891
mobil +49 171 6070008
