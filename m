Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132807AbRD1OQ7>; Sat, 28 Apr 2001 10:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132829AbRD1OQt>; Sat, 28 Apr 2001 10:16:49 -0400
Received: from jalon.able.es ([212.97.163.2]:49632 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132807AbRD1OQb>;
	Sat, 28 Apr 2001 10:16:31 -0400
Date: Sat, 28 Apr 2001 16:16:19 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 sluggish under fork load
Message-ID: <20010428161619.A1062@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.33.0104281322070.1159-100000@ppro.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.33.0104281322070.1159-100000@ppro.localdomain>; from peter.osterlund@mailbox.swipnet.se on Sat, Apr 28, 2001 at 13:52:06 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.28 Peter Osterlund wrote:
> 
> Another thing is that the bash loop "while true ; do /bin/true ; done" is
> not possible to interrupt with ctrl-c.
> 

Just tried that under 2.4.4 on two terminals at the same time and the system
even noticed it. Both cpus were running at about 45%user+55%sys, and was
able to use balsa to read mail (disk access) and both loops stopped
immediatley under Ctrl-C.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.4 #1 SMP Sat Apr 28 11:45:02 CEST 2001 i686

