Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130113AbQK1KZf>; Tue, 28 Nov 2000 05:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130180AbQK1KZZ>; Tue, 28 Nov 2000 05:25:25 -0500
Received: from Cantor.suse.de ([194.112.123.193]:40719 "HELO Cantor.suse.de")
        by vger.kernel.org with SMTP id <S130113AbQK1KZL>;
        Tue, 28 Nov 2000 05:25:11 -0500
Date: Tue, 28 Nov 2000 10:55:06 +0100
Message-Id: <200011280955.eAS9t6I22393@hawking.suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andrea Arcangeli <andrea@suse.de>, kumon@flab.fujitsu.co.jp,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <Pine.GSO.4.21.0011272234550.7352-100000@weyl.math.psu.edu>
X-Yow: I had pancake makeup for brunch!
From: Andreas Schwab <schwab@suse.de>
In-Reply-To: <Pine.GSO.4.21.0011272234550.7352-100000@weyl.math.psu.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.92
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

|> On Tue, 28 Nov 2000, Andrea Arcangeli wrote:
|> 
|> > On Tue, Nov 28, 2000 at 12:10:33PM +0900, kumon@flab.fujitsu.co.jp wrote:
|> > > If you have two files:
|> > > test1.c:
|> > > int a,b,c;
|> > > 
|> > > test2.c:
|> > > int a,c;
|> > > 
|> > > Which is _stronger_?
|> > 
|> > Those won't link together as they aren't declared static.
|> 
|> Try it. They _will_ link together.

Not if you compile with -fno-common, which should actually be the default
some day, IMHO.

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
