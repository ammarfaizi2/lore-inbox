Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130149AbRAEOxL>; Fri, 5 Jan 2001 09:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131706AbRAEOxB>; Fri, 5 Jan 2001 09:53:01 -0500
Received: from ftp.apple.asimov.net ([209.249.142.209]:21001 "HELO
	isaac.asimov.net") by vger.kernel.org with SMTP id <S130149AbRAEOwx>;
	Fri, 5 Jan 2001 09:52:53 -0500
Date: Fri, 5 Jan 2001 06:52:52 -0800
From: Patrick Michael Kane <modus-linux-kernel@pr.es.to>
To: linux-kernel@vger.kernel.org
Subject: reset_xmit_timer errors with 2.4.0
Message-ID: <20010105065251.A8690@pr.es.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Mailer: Mutt http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've installed 2.4.0 on a system that has been tracking 2.3.xx/2.4test for
quite a while.  With 2.4.0 installed, I've started to see the following
errors:

reset_xmit_timer sk=cfd889a0 1 when=0x3b4a, caller=c01e0748
reset_xmit_timer sk=cfd889a0 1 when=0x3a80, caller=c01e0748
reset_xmit_timer sk=cfd889a0 1 when=0x398a, caller=c01e0748
reset_xmit_timer sk=cfd889a0 1 when=0x389e, caller=c01e0748
reset_xmit_timer sk=cfd889a0 1 when=0x37b6, caller=c01e0748

It's a UP system with no kernel patches, running an eepro100 card.  I did
not get these errors under any of the 2.4test kernels.  Should I be worried?

Best,
-- 
Patrick Michael Kane
<modus@pr.es.to>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
