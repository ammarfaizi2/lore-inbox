Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285498AbSAZQXy>; Sat, 26 Jan 2002 11:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285352AbSAZQXd>; Sat, 26 Jan 2002 11:23:33 -0500
Received: from sgie000400.kiv-webservice.de ([195.226.81.253]:18696 "EHLO
	irc.kiv-host.de") by vger.kernel.org with ESMTP id <S285338AbSAZQX3>;
	Sat, 26 Jan 2002 11:23:29 -0500
Message-ID: <4353BABFDF95D311BFC30004AC4CB22AAE3495@sdar000001.kiv-da.de>
From: "Stolle, Martin (KIV)" <MStolle@kiv.de>
To: "'Anish Srivastava '" <anishs@vsnl.com>,
        "'linux-kernel@vger.kernel.org '" <linux-kernel@vger.kernel.org>
Subject: RE: kernel 2.4.17 with -rmap VM patch ROCKS!!!
Date: Sat, 26 Jan 2002 17:23:12 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for your tip.

I installed 2.4.17-rmap-11c and later 2.4.17-rmap-12a on my
2-CPU-Pentium-III
and on one of my 4-CPU-Xeon-III's, and since then, the machine isn't
swapping any
longer.

I use Informix 7.3 and Oracle 8i.

When i used the standard kernel with informix in former times, i had to
reboot often, if there was much traffic on the machine.

I switched to Andrea's kernel patches, from then I hadn't to reboot, but the
backup
(including database consistency check) took 5 hours, and the swap file was
around 200M,
although there was enough RAM (3G)

According to your idea, i switched to 2.4.17-rmap-series.

I don't have to reboot any more, informix runs well, the backup takes only 1
hour 20 minutes,
there is no swap space any longer used.

Thanks to you and Rik van Riels!

I would like if Rik's kernel patches would go into standard.

They are really well!

Martin
-----Original Message-----
From: Anish Srivastava
To: linux-kernel@vger.kernel.org
Sent: 1/24/2002 12:17 PM
Subject: kernel 2.4.17 with -rmap VM patch ROCKS!!!


Hi!
 
 I installed kernel 2.4.17 on my SMP server with 8CPU's and 8GB RAM 
 and lets just say that whenever the entire physical memory was utilised
 the box would topple over...with kswapd running a havoc on CPU
utilization
 So to avoid losing control I had to reboot every 8 hours.
 
 But, it all changed after I applied Rik van Riels 2.4.17-rmap-11c patch
 Now, the box is happily running for the past 3 days under heavy load 
 without any problems. The RAM utilization is always at about 95% +
 but the system doesnt swap at all.....kswapd is running all the time
and 
 freeing up main memory for other processes. I am quite happy with the
 performance of the box........and highly recommend Rik's patches
 for anyone else facing similar problems
 
 Thanks to all you guys, especially Rik for helping me out....
 
 Best regards,
 
 Anish Srivastava
 
 Linux Rulez!!!
 
 
 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
