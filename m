Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130110AbRAEBcP>; Thu, 4 Jan 2001 20:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131182AbRAEBcF>; Thu, 4 Jan 2001 20:32:05 -0500
Received: from waste.org ([209.173.204.2]:16192 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S130110AbRAEBbv>;
	Thu, 4 Jan 2001 20:31:51 -0500
Date: Thu, 4 Jan 2001 19:31:39 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Marko Kreen <marko@l-t.ee>, linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [patch] big udelay's in fb drivers (2.4.0-prerelease)
In-Reply-To: <E14EKLE-0006gk-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0101041814140.14623-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2001, Alan Cox wrote:

> > Once the comments are unweirded, they become completely superfluous. At
> > which point its best not to have them - when someone next comes along and
> > changes the delay, it might end up disagreeing with the comment and
> > causing confusion.
>
> Before you remove the comments check with the author and the manuals.

Huh? Granted that's generally a good idea, but if you've got code that
says

 udelay(15000); /* delay 15ms */

the comment is just extra baggage. No sense touching it generally, but if
you're gonna change it to mdelay..

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
