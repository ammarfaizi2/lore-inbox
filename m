Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130208AbQKXWKl>; Fri, 24 Nov 2000 17:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130307AbQKXWKb>; Fri, 24 Nov 2000 17:10:31 -0500
Received: from styx.suse.cz ([195.70.145.226]:10740 "EHLO kerberos.suse.cz")
        by vger.kernel.org with ESMTP id <S130208AbQKXWKV>;
        Fri, 24 Nov 2000 17:10:21 -0500
Date: Fri, 24 Nov 2000 22:40:18 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Rusty Russell <rusty@linuxcare.com.au>
Cc: Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11)
Message-ID: <20001124224018.A5173@suse.cz>
In-Reply-To: <Pine.LNX.4.21.0011212300590.950-100000@penguin.homenet> <20001123110203.EB8A8813D@halfway.linuxcare.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001123110203.EB8A8813D@halfway.linuxcare.com.au>; from rusty@linuxcare.com.au on Thu, Nov 23, 2000 at 10:01:53PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 10:01:53PM +1100, Rusty Russell wrote:
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

Yes, but if it generates a bigger (== worse) binary?

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
