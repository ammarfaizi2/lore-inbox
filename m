Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTE0Nlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 09:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbTE0Nlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 09:41:42 -0400
Received: from hydra.colinet.de ([194.231.113.36]:8207 "EHLO hydra.colinet.de")
	by vger.kernel.org with ESMTP id S263573AbTE0Nll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 09:41:41 -0400
Subject: 2.5.70 dies on alpha-SMP
To: linux-kernel@vger.kernel.org
Cc: kirk@colinet.de
Message-Id: <kirk-1030527151258.A0117853@hydra.colinet.de>
X-Mailer: TkMail 4.0beta9
From: "T. Weyergraf" <kirk@colinet.de>
Date: Tue, 27 May 2003 15:12:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the stock 2.5.70 dies early upon boot on my alpha UP2000
( dual EV67, DP264 vector ). It happens, after the kernel
tries to start the second CPU. The error happens regardless
of the compilers i tried ( gcc 3.2.3 and 2.95.4 ).

Unfortunately, I do not have a log handy. If that is crucial,
I can rewire my serial console and capture one.

Any Ideas ?


-- 
Thomas Weyergraf                                                kirk@colinet.de
My Favorite IA64 Opcode-guess ( see arch/ia64/lib/memset.S )
"br.ret.spnt.few" - got back from getting beer, did not spend a lot.


