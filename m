Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129145AbQK0PPE>; Mon, 27 Nov 2000 10:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131173AbQK0POo>; Mon, 27 Nov 2000 10:14:44 -0500
Received: from www.ylenurme.ee ([193.40.6.1]:61168 "EHLO ylenurme.ee")
        by vger.kernel.org with ESMTP id <S129145AbQK0POd>;
        Mon, 27 Nov 2000 10:14:33 -0500
Date: Mon, 27 Nov 2000 16:42:13 +0200 (GMT-2)
From: Elmer Joandi <elmer@ylenurme.ee>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Universal debug macros.
In-Reply-To: <200011270835.JAA16502@cave.bitwizard.nl>
Message-ID: <Pine.LNX.4.10.10011271630320.13242-100000@yle-server.ylenurme.sise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Nov 2000, Rogier Wolff wrote:
> Turns out that people will
> prefer to run the "performance" kernel, and they will send in useless
> bugreports like "my just hangs" much more often than now.

But look at positive side:

1. really few people run development kernels despite the "performance" so 
	it probably will be with nondebug kernels.
2. production kernels get more solid
3. because there could be a lot more debug points in development kernels
4. Distributors are interested in shipping debug-kernels.


You see the part that lots of asserts and debug prints  may go.
I see the advantage, that  a lot of them can come, at no cost.

Besides, if you want to have some assert anyway, then do not write it with
system-wide macro but make your own or mark it as "included allways".
Faulty logic.

elmer.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
