Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131827AbQKVAAi>; Tue, 21 Nov 2000 19:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131826AbQKVAAS>; Tue, 21 Nov 2000 19:00:18 -0500
Received: from jalon.able.es ([212.97.163.2]:9974 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131825AbQKVAAM>;
	Tue, 21 Nov 2000 19:00:12 -0500
Date: Wed, 22 Nov 2000 00:30:02 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11)
Message-ID: <20001122003002.C1356@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <20001122001813.A1356@werewolf.able.es> <Pine.LNX.4.21.0011212323450.950-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.21.0011212323450.950-100000@penguin.homenet>; from tigran@veritas.com on Wed, Nov 22, 2000 at 00:26:23 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Nov 2000 00:26:23 Tigran Aivazian wrote:
> On Wed, 22 Nov 2000, J . A . Magallon wrote:
> 
> In the case of kernel, we have to do many things manually, can't rely on
> some compiler (sometimes :). So, the code I pointed you at
> arch/i386/kernel/head.S (look for "Clear BSS") is in fact what clears the
> BSS; without it you will end up with uninitialized garbage in what you
> think "ANSI C compiler arranged" for you.
> 

Thanks, that makes everything clear...I'm very suspicious on compilers.
Last thing I saw was VisualC++ skipping constructors...but that is
off-topic, we talked about 'compilers'...

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux 2.2.18-pre22-vm #7 SMP Sun Nov 19 03:29:20 CET 2000 i686 unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
