Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130423AbQKZA3R>; Sat, 25 Nov 2000 19:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130996AbQKZA3H>; Sat, 25 Nov 2000 19:29:07 -0500
Received: from boss.staszic.waw.pl ([195.205.163.66]:51975 "EHLO
        boss.staszic.waw.pl") by vger.kernel.org with ESMTP
        id <S130423AbQKZA24>; Sat, 25 Nov 2000 19:28:56 -0500
Date: Sun, 26 Nov 2000 00:56:29 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
To: Rusty Russell <rusty@linuxcare.com.au>
cc: Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11) 
In-Reply-To: <20001123110203.EB8A8813D@halfway.linuxcare.com.au>
Message-ID: <Pine.LNX.4.21.0011260047560.3136-100000@tricky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2000, Rusty Russell wrote:

> In message <Pine.LNX.4.21.0011212300590.950-100000@penguin.homenet> you write:
> > > On Tue, 21 Nov 2000 22:25:01 Bartlomiej Zolnierkiewicz wrote:
> > > > 
> > > > Quick removal of unnecessary initialization to 0.
> > 
> > Quite the contrary. The patch seems correct and useful to me. What do you
> > think is wrong with it? (Linus accepted megabytes worth of the above in
> > the past...)
>
> What irritates about these monkey-see-monkey-do patches is that if I
> initialize a variable to NULL, it's because my code actually relies on
> it; I don't want that information eliminated.
 
What irritates about these monkey-do-not-read-monkey-write e-mails
is that I know what I am doing :) My patch removed *REALLY* unnecessary
initialization, no code depended on beginning value so don't quote
my words...

--
Bartlomiej Zolnierkiewicz
<bkz@linux-ide.org>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
