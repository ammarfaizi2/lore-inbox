Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130836AbQLTETu>; Tue, 19 Dec 2000 23:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130873AbQLTETk>; Tue, 19 Dec 2000 23:19:40 -0500
Received: from quechua.inka.de ([212.227.14.2]:12600 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S130836AbQLTETb>;
	Tue, 19 Dec 2000 23:19:31 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: /dev/random: really secure?
Message-Id: <E148aFT-0001WO-00@calista.inka.de>
Date: Wed, 20 Dec 2000 04:49:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001218102218.A428@albireo.ucw.cz> you wrote:
> Even if you were able to predict all entropy sources, to predict the generated
> random numbers you would need to invert the cryptographic hash used there.

If you can predict ALL input in the pool, including the initial boot state
you can just rerun the PNRG algorithm and get the random numbers (as long as
you even can predict read access to the device).

But thats not the real-world Attack. The Real world attack is more to reduce
the randomness in terms of stochastic tests can detect some patterns like
unequal distribution or cycles. Those will lower the strengt of some
algorithms...

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
