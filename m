Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129647AbRBKQWs>; Sun, 11 Feb 2001 11:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129643AbRBKQW2>; Sun, 11 Feb 2001 11:22:28 -0500
Received: from Guard.PolyNet.Lviv.UA ([217.9.2.1]:34061 "HELO
	guard.polynet.lviv.ua") by vger.kernel.org with SMTP
	id <S129614AbRBKQWR>; Sun, 11 Feb 2001 11:22:17 -0500
Date: 11 Feb 2001 18:17:44 +0200
Message-ID: <1394806431.20010211181744@polynet.lviv.ua>
From: "Andriy Korud" <akorud@polynet.lviv.ua>
Reply-To: "Andriy Korud" <akorud@polynet.lviv.ua>
To: linux-kernel@vger.kernel.org
X-Mailer: The Bat! (v1.49)
X-Priority: 3 (Normal)
Subject: Where are you going with 2.4.x?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
I'd like to post here me experience of using new Linux kernels both at
home and on enterprise server.
At home I'm using new branch since 2.3.x - it works really fine for
home work, multimedia, etc. Nice work, thanks.
But on our enterprise server It's something awful.
Server hardware is: PIII 500Mhz, Intel 440GX, 512 ECC RAM, 2xAdaptec 7xxx +
Mylex AccelRAID 250 disk subsystem.
Server software is 2 instances of Oracle 8i (8.1.6 and 8.1.7).
No kernel modules, no inet services, only Oracle.
On 2.2.x this run more or less stable (it usually crash or hang once
per month, but it's acceptable).
I've installed 2.4.x there. Just immedualtely I've noticed performance
improve, responce time improve.
BUT: All kernels prior to 2.1.4-ac8 hangs during first few hours of
work on heavy disk (Mylex) activity.
2.1.4-ac8 was the first kernel which was able to work nore then 24
hours. But on 26'th our of work it crashed with:

       Kernel panic: Aiee:, killing interrupt handler!
       In interrupt handler - not syncing

So, again I've downgraded kernel to 2.2.18 again :(

Can I know your thoughts about target market of 2.4.x kernel? I assume
that the goal is to make it feature-rich multimedia desktop system?
Personally I now look how to run Oracle under FreeBSD which is much
more stable on the same hardware at high load (corporate Squid).


  

-- 
Best regards,
 Andriy                          mailto:akorud@polynet.lviv.ua


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
