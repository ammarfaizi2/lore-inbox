Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130656AbQK1WoC>; Tue, 28 Nov 2000 17:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131320AbQK1Wnx>; Tue, 28 Nov 2000 17:43:53 -0500
Received: from e166066.upc-e.chello.nl ([213.93.166.66]:25348 "EHLO Ion.var.cx")
        by vger.kernel.org with ESMTP id <S131273AbQK1Wnq>;
        Tue, 28 Nov 2000 17:43:46 -0500
Date: Tue, 28 Nov 2000 23:13:34 +0100
From: Frank v Waveren <fvw@var.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no RLIMIT_NPROC for root, please
Message-ID: <20001128231334.A438@var.cx>
In-Reply-To: <20001128222040.H2680@sith.mimuw.edu.pl> <E140slT-000565-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E140slT-000565-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Nov 28, 2000 at 09:58:14PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2000 at 09:58:14PM +0000, Alan Cox wrote:
> > Because you want to be able to `kill <pid>`?
> > And if you are over-limits you can't?
> Wrong. limit is a shell built in

I assume you mean kill is a shell builtin. Depending on your shell. :-).
It's still a real pain when you want to get the pid of the offending
proces(ses). You could of course do something like
for a in /proc/*; do echo -en "$a "; cat $a/cmdline; echo; done (it'll
barf a lot, but give a reasonable picture)...

Anyways, this is all not relevant, imho the whole point is moot.
"I don't like root having rlimits."
"So don't setrlimit root."

No reason to ditch functionality.

-- 

                        Frank v Waveren
                        fvw@[var.cx|stack.nl|chello.nl|dse.nl]
                        ICQ# 10074100
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
