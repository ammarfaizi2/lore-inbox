Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131114AbQLJREm>; Sun, 10 Dec 2000 12:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131078AbQLJREc>; Sun, 10 Dec 2000 12:04:32 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:56082 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130842AbQLJRES>;
	Sun, 10 Dec 2000 12:04:18 -0500
Message-ID: <3A33B06A.84ED5D58@mandrakesoft.com>
Date: Sun, 10 Dec 2000 11:33:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
CC: Linus Torvalds <torvalds@transmeta.com>, rgooch@ras.ucalgary.ca,
        jgarzik@mandrakesoft.mandrakesoft.com, dhinds@valinux.com,
        linux-kernel@vger.kernel.org
Subject: Re: Serial cardbus code.... for testing, please.....
In-Reply-To: <200012100707.CAA17906@tsx-prime.MIT.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Y. Ts'o" wrote:
> In any case, I think I know how to fix the serial driver to not loop in
> receive_chars().  If I get this working, do you want to take a serial
> driver update now or post 2.4.0?  I have a number of fixes queued up
> that I didn't consider critical, so I haven't fed them to you.  One of
> them is from an SGI engineer who's been harassing me about getting one
> of the changes in, since he's apparently on deadline and he needs a
> change for one of his SGI MIPS boxes.  I don't understand why he can't
> just use a kernel with a patch, but whatever...

FWIW I don't think you should sit on fixes until post 2.4.0...  and I
would like to get CardBus serial working because it's broken in the
current tree...

	Jeff


-- 
Jeff Garzik         |
Building 1024       | These are not the J's you're lookin' for.
MandrakeSoft        | It's an old Jedi mind trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
