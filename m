Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130159AbQKXVOP>; Fri, 24 Nov 2000 16:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129866AbQKXVOE>; Fri, 24 Nov 2000 16:14:04 -0500
Received: from [193.120.245.10] ([193.120.245.10]:59908 "HELO
        halfway.linuxcare.com.au") by vger.kernel.org with SMTP
        id <S129835AbQKXVNt>; Fri, 24 Nov 2000 16:13:49 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11) 
In-Reply-To: Your message of "Tue, 21 Nov 2000 23:04:53 BST."
             <Pine.LNX.4.21.0011212300590.950-100000@penguin.homenet> 
Date: Thu, 23 Nov 2000 22:01:53 +1100
Message-Id: <20001123110203.EB8A8813D@halfway.linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.21.0011212300590.950-100000@penguin.homenet> you write:
> > On Tue, 21 Nov 2000 22:25:01 Bartlomiej Zolnierkiewicz wrote:
> > > 
> > > Quick removal of unnecessary initialization to 0.
> 
> Quite the contrary. The patch seems correct and useful to me. What do you
> think is wrong with it? (Linus accepted megabytes worth of the above in
> the past...)

What irritates about these monkey-see-monkey-do patches is that if I
initialize a variable to NULL, it's because my code actually relies on
it; I don't want that information eliminated.

Rusty.
--
Hacking time.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
