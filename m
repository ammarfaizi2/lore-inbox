Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130070AbQLMAML>; Tue, 12 Dec 2000 19:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130180AbQLMAMC>; Tue, 12 Dec 2000 19:12:02 -0500
Received: from jalon.able.es ([212.97.163.2]:46811 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130070AbQLMALx>;
	Tue, 12 Dec 2000 19:11:53 -0500
Date: Wed, 13 Dec 2000 00:41:19 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Jussi Laako <jussi@jlaako.pp.fi>
Cc: Marc Mutz <Marc@Mutz.com>, linux-kernel@vger.kernel.org
Subject: Re: VM problem (2.4.0-test11)
Message-ID: <20001213004119.A779@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <3A36A163.3F01277D@jlaako.pp.fi> <3A36ADB8.3CE36940@Mutz.com> <3A36B3E5.CF9FC31D@jlaako.pp.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A36B3E5.CF9FC31D@jlaako.pp.fi>; from jussi@jlaako.pp.fi on Wed, Dec 13, 2000 at 00:25:25 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Dec 2000 00:25:25 Jussi Laako wrote:
> Marc Mutz wrote:
> > 
> > Just to not miss the obvious: You know about ulimit(3)?
> 
> Yes, but it doesn't stop deadlocks caused by kernel's VM system going
> wild... I think that no matter what user process does, root should be always
> able to stop it. User process should never be able to render whole system
> unusable.
> 

That is just some issue that was discussed in this list recently. Look in the
list
for 'oom killer' subjects.
There are various patches-ways-to-do available, kernel gurus are still working
on it...
(leave always some 4% of mem for root, kill some process when mem is exhausted,
which one to kill...)

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux werewolf 2.2.18-aa1 #1 SMP Mon Dec 11 21:26:28 CET 2000 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
