Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263975AbRFENeb>; Tue, 5 Jun 2001 09:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263976AbRFENeV>; Tue, 5 Jun 2001 09:34:21 -0400
Received: from [217.6.75.12] ([217.6.75.12]:5618 "EHLO ftp.prs.de")
	by vger.kernel.org with ESMTP id <S263975AbRFENeS>;
	Tue, 5 Jun 2001 09:34:18 -0400
Message-ID: <3B1CE135.2D82A977@prs.de>
Date: Tue, 05 Jun 2001 15:40:05 +0200
From: Till Immanuel Patzschke <tip@prs.de>
Reply-To: tip@prs.de
Organization: interNetwork AG
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: lots of pppd (down) stall SMP linux-2.4.x
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I have a pretty nasty problem w/ pppd (2.4.0) on SMP versions of 2.4.x (I've
tried 2.4.0.SuSE to 2.4.4).
I am running >25 pppds on a Dual-Pentium933, 3GB, Asus CUR-DLS motherboard
(ServerWorks SE). The pppds are running fine (I am using pppoe plugin from
Michael Ostrowski, and/or a user process doing the PPPoE). BUT once I try to
bring the ppds down to fast (killall is a perfect way) the system stalls, i.e.
no Oops, no login etc. however, switching consoles via keyboard works, ping'ing
the IP from the net still works. None of the log files hold any useful
information...
If I bring the pppds down using a slow loop (one kill per second or slower) the
machine does NOT stall.
I'v tried many different SMP related patches from this list (ppp_async, tty) but
none of them helped on my problem.
And - of course - the problem does NOT exist on the same box using the same
kernel base w/o SMP support!!!

Any help is very much appreciated!
Thanks

Immanuel

--
Till Immanuel Patzschke                 mailto: tip@internetwork-ag.de
interNetwork AG                         Phone:  +49-(0)611-1731-121
Bierstadter Str. 7                      Fax:    +49-(0)611-1731-31
D-65189 Wiesbaden                       Web:    http://www.internetwork-ag.de





