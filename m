Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQKUX0I>; Tue, 21 Nov 2000 18:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129412AbQKUXZ5>; Tue, 21 Nov 2000 18:25:57 -0500
Received: from jalon.able.es ([212.97.163.2]:2293 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129319AbQKUXZk>;
	Tue, 21 Nov 2000 18:25:40 -0500
Date: Tue, 21 Nov 2000 23:55:29 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11)
Message-ID: <20001121235529.E925@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <Pine.LNX.4.21.0011211438490.756-100000@tricky>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.21.0011211438490.756-100000@tricky>; from dake@staszic.waw.pl on Tue, Nov 21, 2000 at 22:25:01 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Nov 2000 22:25:01 Bartlomiej Zolnierkiewicz wrote:
> 
> Quick removal of unnecessary initialization to 0.
> 
>  
> -static int basePort = 0;	/* base port address */
> -static int regPort = 0;		/* port for register number */
> -static int dataPort = 0;	/* port for register data */
> +static int basePort;	/* base port address */
> +static int regPort;	/* port for register number */
> +static int dataPort;	/* port for register data */

That is not too much confidence on the ANSI-ness of the compiler ???

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux 2.2.18-pre22-vm #7 SMP Sun Nov 19 03:29:20 CET 2000 i686 unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
