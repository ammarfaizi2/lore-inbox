Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbRBEMQd>; Mon, 5 Feb 2001 07:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129448AbRBEMQX>; Mon, 5 Feb 2001 07:16:23 -0500
Received: from bastion.power-x.co.uk ([62.232.19.201]:43269 "EHLO
	bastion.power-x.co.uk") by vger.kernel.org with ESMTP
	id <S129116AbRBEMQL>; Mon, 5 Feb 2001 07:16:11 -0500
Date: Mon, 5 Feb 2001 12:16:48 +0000 (GMT)
From: "Dr. David Gilbert" <dg@px.uk.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>, <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink
 related)
In-Reply-To: <E14PkHY-0003BN-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0102051215180.1654-100000@springhead.px.uk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2001, Alan Cox wrote:

> > In an __init function, have some code that will trigger the bug.
> > This can be used to disable Reiserfs if the compiler was bad.
> > Then the admin gets a printk() and the Reiserfs mount fails.
>
> Thats actually quite doable. I'll see about dropping the test into -ac that
> way.

It would actually be nice to have a whole collect of compiler tests in the
kernel; whenever we fall over a compiler bug add the test and leave it in.
Possibly as a separate block of the code.

One thing to remember is not to test for compiler versions; versions which
cause problems on x86 might work fine on real systems and the otherway
round.

Dave

-- 
/------------------------------------------------------------------\
| Dr. David Alan Gilbert | Work:dg@px.uk.com +44-161-286-2000 Ex258|
| -------- G7FHJ --------|---------------------------------------- |
| Home: dave@treblig.org            http://www.treblig.org         |
\------------------------------------------------------------------/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
