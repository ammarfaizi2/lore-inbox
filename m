Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264678AbTFQL5h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 07:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264680AbTFQL5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 07:57:36 -0400
Received: from arm.t19.ds.pwr.wroc.pl ([156.17.236.105]:39688 "EHLO misie.k.pl")
	by vger.kernel.org with ESMTP id S264678AbTFQL5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 07:57:35 -0400
Date: Tue, 17 Jun 2003 14:11:29 +0200
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.72: drivers/ide/legacy/pdc4030.c:843: error: `hwif' undeclared (first use in this function)
Message-ID: <20030617121129.GA9606@arm.t19.ds.pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
X-URL: http://www.t17.ds.pwr.wroc.pl/~misiek/
X-Operating-System: Linux dark 4.0.20 #119 wto cze 17 14:07:57 CEST 2003 i986 pld
Organization: Self Organizing
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While building 2.5.72 (+lsm patch):

 CC [M]  drivers/ide/legacy/pdc4030.o
drivers/ide/legacy/pdc4030.c: In function `promise_multwrite':
drivers/ide/legacy/pdc4030.c:617: warning: `return' with a value, in
function returning void
drivers/ide/legacy/pdc4030.c: In function `promise_write_pollfunc':
drivers/ide/legacy/pdc4030.c:627: warning: unused variable `rq'
drivers/ide/legacy/pdc4030.c: In function `promise_rw_disk':
drivers/ide/legacy/pdc4030.c:843: error: `hwif' undeclared (first use in
this function)
drivers/ide/legacy/pdc4030.c:843: error: (Each undeclared identifier is
reported only once
drivers/ide/legacy/pdc4030.c:843: error: for each function it appears
in.)
make[3]: *** [drivers/ide/legacy/pdc4030.o] B³±d 1
make[2]: *** [drivers/ide/legacy] B³±d 2
make[1]: *** [drivers/ide] B³±d 2

kernel config is here:
http://www.t17.ds.pwr.wroc.pl/~misiek/rozne/kernel-2.5/kernel-2.5.72-lsm.config

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekmatssedotpl AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux
