Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270117AbRHGH2G>; Tue, 7 Aug 2001 03:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270120AbRHGH1q>; Tue, 7 Aug 2001 03:27:46 -0400
Received: from mackman.submm.caltech.edu ([131.215.85.46]:32128 "EHLO
	mackman.net") by vger.kernel.org with ESMTP id <S270117AbRHGH1j>;
	Tue, 7 Aug 2001 03:27:39 -0400
Date: Tue, 7 Aug 2001 00:26:58 -0700 (PDT)
From: Ryan Mack <rmack@mackman.net>
To: Evgeny Polyakov <johnpol@2ka.mipt.ru>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Encrypted Swap
In-Reply-To: <200108070705.f7775xl27094@www.2ka.mipt.ru>
Message-ID: <Pine.LNX.4.33.0108070023370.5641-100000@mackman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, computer can not do this.
> This will do some program,and this program is not crypted.
> Yes?
> We disassemle this program, get algorithm and regenerate a key in evil machine?
> Am i wrong?

Any algoritm can be reproduced, yes, but a strong random number source
cannot.  See my other email for an example of such.

> P.S. off-topic What algorithm do you want to use to regenerate a key for once crypted data?
> I don't know anyone, or i can't understand your point of view.

If the algorithm is strong enough, the only method is a brute force search
of the entire keyspace, which in the case of a 2048 bit key would take
much longer than the age of the universe, even using a billion times the
total computational power of the earth.  Simple algoritms are subject to
frequency analysis and other more subtle analysis.  Pick up a copy of
"Applied Cryptography" by Bruce Schneier for a generaly overview of the
field.

