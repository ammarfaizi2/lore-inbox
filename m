Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132704AbRA3Wiz>; Tue, 30 Jan 2001 17:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132785AbRA3Wip>; Tue, 30 Jan 2001 17:38:45 -0500
Received: from usuario0-37-165-207.dialup.uni2.es ([62.37.165.207]:56992 "EHLO
	TeLeNiEkO") by vger.kernel.org with ESMTP id <S132704AbRA3Wij>;
	Tue, 30 Jan 2001 17:38:39 -0500
Date: Tue, 30 Jan 2001 23:35:49 +0100
From: TeLeNiEkO <telenieko@telenieko.com>
To: linux-kernel@vger.kernel.org
Subject: 2 Possible bugs, 1 'stuff'
Message-ID: <20010130233549.A5149@telenieko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-Mailer: Mutt 1.3.12i
X-Editor: GNU Emacs 20.7.2
X-Info: http://www.telenieko.com
X-Operating-System: Linux(TeLeNiEkO)/2.4.0 (i686)
X-Uptime: 11:23pm  up 9 days, 10:26,  8 users,  load average: 0.27, 0.27, 0.26
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On kernel 2.4.0:
 The ne2k-pci driver (NE2000 PCI) cannont be compiled as a module. I tried it on two computers and I had really hard problems.
 I built it in. If this wasn't notified yet let me know and I'll recompile the kernel to get the exact error message and bring it to you. (It was about unresolved simbols, you won't need to habe the card to see it!)

The other think is about Traffic Shaping and QoS:
Wendy:/etc/ipconf# tc filter add dev eth1 parent 1:0 protocol ip prio 100 u32 match ip dst 192.168.0.69 flowid 1:2
RTNETLINK answers: Invalid argument

Both 1:0 and 1:2 are created, and according to the howto that should run (and it did on 2.2.18), if you want I'll send you a complete list of the commands issued to 'tc'.

(Traffic Shaper and QoS was compiled as built-in, i got more unresolved simbols having them as modules!)

The other thing...
 Many new users are coming to linux world. But the BUG-HUNTING really goes far for a lot of people. Many people are trying linux for first time, after 2 months they try to get witth kernel update and OOOhh, they find a bug! then:
 a) They don't find a nice button to notify the bug on their desktop... and the most clever can't find it on a website.
 b) When they read the BUG-HUNTING doc they just get the windows CD and go back to monkeys world.

So, as Linux intends to approach to more "home-users" each day, there should be an easier way to notify bugs, for thoose users. Remember that it's while you mess up with things is when bugs appear. 
And there's nothing better than a novice user to mess-up with a kernel ;o)

So, try to find an easier, but reallybly way, for notifiing bugs (a form on kernel.org won't do much!)

And let me know about the ne2k-pci and TF bugs (if they are).

sincerelly,
 TeLeNiEkO (Barcelona, Spain)

PD: If you want full info about one of the "bugs" let me know, and I'll do my best to recompile the kernel.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
