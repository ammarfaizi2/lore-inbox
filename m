Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131027AbQK1Vld>; Tue, 28 Nov 2000 16:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131212AbQK1VlY>; Tue, 28 Nov 2000 16:41:24 -0500
Received: from Cantor.suse.de ([194.112.123.193]:28688 "HELO Cantor.suse.de")
        by vger.kernel.org with SMTP id <S131027AbQK1VlJ>;
        Tue, 28 Nov 2000 16:41:09 -0500
Date: Tue, 28 Nov 2000 22:11:07 +0100
Message-Id: <200011282111.eASLB6k05926@hawking.suse.de>
To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no RLIMIT_NPROC for root, please
In-Reply-To: <20001128214309.F2680@sith.mimuw.edu.pl>
X-Yow: All I can think of is a platter of organic PRUNE CRISPS being trampled
 by an army of swarthy, Italian LOUNGE SINGERS...
From: Andreas Schwab <schwab@suse.de>
In-Reply-To: <20001128214309.F2680@sith.mimuw.edu.pl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.92
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Rekorajski <baggins@sith.mimuw.edu.pl> writes:

|> Why is RLIMIT_NPROC apllied to root(uid 0) processes? It's not kernel job to
|> prevent admin from shooting him/her self in the foot.
|> 
|> root should be able to do fork() regardless of any limits,
|> and IMHO the following patch is the right thing.

AFAICS, _all_ resource limits are equally applied to root processes.  Why
should NPROC be different?

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
