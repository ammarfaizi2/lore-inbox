Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135258AbRAHVuw>; Mon, 8 Jan 2001 16:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135257AbRAHVum>; Mon, 8 Jan 2001 16:50:42 -0500
Received: from medusa.sparta.lu.se ([194.47.250.193]:13090 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S135273AbRAHVu3>; Mon, 8 Jan 2001 16:50:29 -0500
Date: Mon, 8 Jan 2001 21:31:53 +0100 (MET)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: setfsuid on ext2 weirdness (2.4)
In-Reply-To: <200101082021.MAA04177@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.96.1010108212153.21951A-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Linus Torvalds wrote:
> Please show them, anyway. What does "ls -ld / /etc /etc/passwd" say?

Heh... /etc and /etc/passwd were allright... but / was fscked (or not,
maybe :)

drwx--------- 500 0       both locked from other users and 500 as owner..

> 99% says that one of the three will be wrong (probably "/", because you
> probably checked the others already and overlooked root), and you'll
> feel really silly. 

Dunno how that ever happened (unpacking a bad tar-ball maybe) but it's
fixed now and Linux 2.4.0 is completely without blame! :) I'm stupendously
silly but that's just normal, also, it's another warm unix experience to
cherish..

Thanks for the hint!

> And hey, if you think the above is confusing, try making your /dev/null
> a regular (writable) file by mistake.  Now THAT will be confusing as

Been there got the t-shirt :)

/BW

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
