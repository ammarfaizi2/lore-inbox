Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271915AbRIDJCK>; Tue, 4 Sep 2001 05:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271916AbRIDJB7>; Tue, 4 Sep 2001 05:01:59 -0400
Received: from picard.auto.tuwien.ac.at ([128.130.12.4]:46234 "EHLO
	picard.auto.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S271915AbRIDJBm>; Tue, 4 Sep 2001 05:01:42 -0400
Date: Tue, 4 Sep 2001 11:02:01 +0200 (CEST)
From: Heinz Deinhart <heinz@auto.tuwien.ac.at>
To: <linux-kernel@vger.kernel.org>
Subject: Some experiences with the Athlon optimisation problem
Message-ID: <Pine.LNX.4.33.0109041055250.25091-100000@xenon.auto.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i might have found some interesting informations regarding the Athlon
optimisation problems. I have two different Athlon versions, the
older one seems to work very table, the newer one crashes always
during system startup.  Both chips where running in exactly the same
machine. (the older one is a 1.133Ghz the newer one a 1.2Ghz.)

I tried 2.4.9, 2.4.9-ac6 and 2.4.3, not difference. The system is a
MSI-K7A Turbo with KT133A from VIA, 256MB PC133 RAM. I have 8 of the
new ones, and all of them do not work.

Because the same system is stable with one kind of Athlons and does
not work with the other, couldn't this mean those Athlons are buggy ?

Of course all troubles vanish when i turn off Athlon optimisation. But
this probably doesnt kill the problem.

The old Athlon reads:
	A1133AMS3C
	AVIA 0115TPAW
	95262550081

The new (non working) one:
	A1200AMS3C
	AXIA 0121RPDW
	95987660990

I hope this is somehow useful.

ciao,
heinz

-- 
Heinz Deinhart <heinz@auto.tuwien.ac.at>
+43 1 58801-18321
Technische Universitaet Wien, Dept. E183/1

