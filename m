Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129985AbQLAW47>; Fri, 1 Dec 2000 17:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129974AbQLAW4j>; Fri, 1 Dec 2000 17:56:39 -0500
Received: from Unable.to.handle.kernel.NULL.pointer.dereference.de ([212.6.215.146]:57609
	"EHLO inode.real-linux.de") by vger.kernel.org with ESMTP
	id <S129771AbQLAW4c>; Fri, 1 Dec 2000 17:56:32 -0500
Date: Fri, 1 Dec 2000 23:25:57 +0100
From: Florian Heinz <sky@dereference.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Some problems with the raid-stuff in 2.4.0-test12pre3
Message-ID: <20001201232557.D2087@inode.real-linux.de>
In-Reply-To: <20001130123322.A672@inode.real-linux.de> <14887.2273.174231.960990@notabene.cse.unsw.edu.au> <20001201105233.D672@inode.real-linux.de> <14888.635.655989.944747@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14888.635.655989.944747@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Sat, Dec 02, 2000 at 06:56:43AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2000 at 06:56:43AM +1100, Neil Brown wrote:
> On Friday December 1, sky@dereference.de wrote:
> > It's so slow that it's unusable. Especially writing. open() and
> > close()-calls often hang for 20 seconds or more.
> > write-calls hang for 3-4 seconds. This has to be a bug.
> > But yes, after a long time, it finishes ;)
> 
> Well, that does sound slower than I would expect....
> 
> 1/ Could you try:
> 
>    http://cgi.cse.unsw.edu.au/~neilb/patches/linux/2.4.0-test12-pre3/patch-E-raid5
> 
>    and tell me how much that helps.

That helped a _lot_! It's still slower than 2.2.x, but I'm happy with it!
Thank you.
I'm at your service if you need more testing ;)

Regards

Florian Heinz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
