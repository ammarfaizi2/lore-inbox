Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289096AbSAGDIa>; Sun, 6 Jan 2002 22:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289098AbSAGDIV>; Sun, 6 Jan 2002 22:08:21 -0500
Received: from are.twiddle.net ([64.81.246.98]:42624 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S289096AbSAGDIJ>;
	Sun, 6 Jan 2002 22:08:09 -0500
Date: Sun, 6 Jan 2002 19:08:01 -0800
From: Richard Henderson <rth@twiddle.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Davide Libenzi <davidel@xmailserver.org>, Ingo Molnar <mingo@elte.hu>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
Message-ID: <20020106190801.A27356@twiddle.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Davide Libenzi <davidel@xmailserver.org>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0201051753090.1607-100000@blue1.dev.mcafeelabs.com> <E16N2oW-00021c-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16N2oW-00021c-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Jan 06, 2002 at 02:13:32AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2002 at 02:13:32AM +0000, Alan Cox wrote:
> ... since an 8bit ffz can be done by lookup table
> and that is fast on all processors

Please still provide the arch hook -- single cycle ffs type
instructions are still faster than any memory access.


r~
