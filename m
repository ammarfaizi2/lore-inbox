Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129448AbQJ3Tdc>; Mon, 30 Oct 2000 14:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129224AbQJ3TdW>; Mon, 30 Oct 2000 14:33:22 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:31752 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129448AbQJ3TdJ>; Mon, 30 Oct 2000 14:33:09 -0500
From: Mirko.Klemm@t-online.de (Mirko Klemm)
Date: Mon, 30 Oct 2000 20:33:06 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test9 pppoe broken?
MIME-Version: 1.0
Message-Id: <00103020330603.00684@trabant>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I just upgraded from test7 to test9, now the pppoe (to be precise, pppox on 
which pppoe depends)  module segfaults when loaded with modprobe the first 
time, a second attempt causes lots of disk activity and eats up all processor 
time, eventually locking me out of my system (no oops, though, so I guess 
it's actually modprobe that crashes).
I use modutils 2.3.14, and I got pppox device nodes in my /dev on major 144 
from a different pppox module, a third-party pppoe implementation that was 
partly user and partly kernel based as opposed to the all-kernel 2.4.0 
solution. As everything works fine with test7 I wonder what has changed in 
test9. What could be wrong here? Any ideas?

Thanks,
Mirko
------------------------------------------------------
Mirko Klemm

Mirko.Klemm@t-online.de

GPG-Public Key at:
http://www.mutantenzoo.de/mklemm.asc

encrypted messages preferred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
