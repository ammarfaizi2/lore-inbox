Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284813AbRLHUnk>; Sat, 8 Dec 2001 15:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285174AbRLHUnb>; Sat, 8 Dec 2001 15:43:31 -0500
Received: from hera.cwi.nl ([192.16.191.8]:35566 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S284813AbRLHUnU>;
	Sat, 8 Dec 2001 15:43:20 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 8 Dec 2001 20:43:17 GMT
Message-Id: <UTC200112082043.UAA254046.aeb@cwi.nl>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: Would the father of init_mem_lth please stand up
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Alan Cox <alan@lxorguk.ukuu.org.uk>

    > Really someone needs slapping across. What kind of code is that
    > (in 2.5.1-pre6):

    Whoever merged that crap also wants a good kicking. First we have the joke
    ps/2 merge, now this. Is Linus trying to force someone to take over or is
    small children combined with a pending christmas really the doom that some
    folks claim 8)

Alan, Alan,

Please calm down. Linus is doing a good job, and whenever things
go slightly wrong someone comes along to point out the flaw.
Moreover, I can assure you that pending christmas and small children
really is a very nice time.
And then, my beautiful code is not at all crap that should not
have been applied. It fixes a real bug. But there was another bug
there that it left, namely that the freed pointers should have been
zeroed, so that nobody can come and use them with random results.
If nobody else does it, I'll send also that small fix, but maybe
not today.

Andries
