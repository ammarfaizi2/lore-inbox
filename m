Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBNRj0>; Wed, 14 Feb 2001 12:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129075AbRBNRjP>; Wed, 14 Feb 2001 12:39:15 -0500
Received: from zeus.kernel.org ([209.10.41.242]:55257 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129066AbRBNRjJ>;
	Wed, 14 Feb 2001 12:39:09 -0500
From: Carlos Carvalho <carlos@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14986.49817.44381.454285@hoggar.fisica.ufpr.br>
Date: Wed, 14 Feb 2001 15:38:33 -0200
To: Sean Hunter <sean@dev.sportingbet.com>
Cc: jbglaw@lug-owl.de, linux-kernel@vger.kernel.org,
        axp-hardware@talisman.alphalinux.org
Subject: Re: Alpha: bad unaligned access handling
In-Reply-To: <20010214172607.E11048@dev.sportingbet.com>
In-Reply-To: <20010214154808.A15974@lug-owl.de>
	<14986.48181.55212.358637@hoggar.fisica.ufpr.br>
	<20010214172607.E11048@dev.sportingbet.com>
X-Mailer: VM 6.90 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Hunter (sean@dev.sportingbet.com) wrote on 14 February 2001 17:26:
 >This is an application problem, not a kernel one.  You need to upgrade your
 >netkit.

Yes, I was quite confident of this. However, unaligned traps are a
frequent problem with alphas. For a looong time we had zsh produce
lots of it, to the point of making it unusable. Strangely, the problem
disappeared without changing anything in zsh. It was either a library
or kernel problem.

 >P.S. I wrote a small wrapper to aid in the debugging of unaligned
 >traps, which I'll send to anyone who's interested.

I'd like it!
