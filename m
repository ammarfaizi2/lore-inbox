Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285570AbRLNWvK>; Fri, 14 Dec 2001 17:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285572AbRLNWvA>; Fri, 14 Dec 2001 17:51:00 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:58635 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S284553AbRLNWuw>;
	Fri, 14 Dec 2001 17:50:52 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: linux-kernel@vger.kernel.org
Date: Fri, 14 Dec 2001 23:50:32 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: ECP Parallel Port
CC: makemehappy@rocketmail.com, philip.blundell@pobox.com
X-mailer: Pegasus Mail v3.40
Message-ID: <C01668F6B4E@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  one of VMware users just pointed to me that ECP mode is now broken 
in kernel. 2.4.10-ac9 reports correctly:

0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport_pc: Via 686A parallel port: io=0x378

while 2.4.12-ac1 (and all following up to and including 2.4.17-rc1) say just:

parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport_pc: Via 686A parallel port: io=0x378

It looks like a bug to me. Is it known problem, or should I look into
it more deeply?
                                            Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
