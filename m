Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129429AbQLMXXd>; Wed, 13 Dec 2000 18:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129826AbQLMXXW>; Wed, 13 Dec 2000 18:23:22 -0500
Received: from mail4.mia.bellsouth.net ([205.152.144.16]:51344 "EHLO
	mail4.mia.bellsouth.net") by vger.kernel.org with ESMTP
	id <S129429AbQLMXXV>; Wed, 13 Dec 2000 18:23:21 -0500
Message-ID: <3A37B719.7EFF2C44@bellsouth.net>
Date: Wed, 13 Dec 2000 17:51:21 +0000
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: test12: innd bug came back?
In-Reply-To: <918pmt$q9s$1@osiris.storner.dk> <Pine.GSO.4.21.0012131646070.5045-100000@weyl.math.psu.edu> <918rml$53u$1@penguin.transmeta.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And the problem started with pre8 not final.
currently investigating difference pre7-pre8
Albert
Linus Torvalds wrote:
> 
> In article <Pine.GSO.4.21.0012131646070.5045-100000@weyl.math.psu.edu>,
> Alexander Viro  <viro@math.psu.edu> wrote:
> >
> >
> >On 13 Dec 2000, Henrik [ISO-8859-1] Størner wrote:
> >
> >> Just to add a "me too" on this. I didn't report when I saw it last week,
> >> because I was uncertain of exactly what might have caused it - I was
> >> booting several different kernels at the time, including one from a
> >> rescue disk (I was trying to salvage bits of a Win9x disk at the time -
> >> don't ask for details!)
> >>
> >> Alas, I lost the test program someone wrote to test for the truncate
> >> problem, and due to moving I will not be able to test anything until
> >> next Monday. But if needed, I can do some testing then. Something
> >> definitely went wrong with innd during the test12 pre-patches.
> >
> >It may be a side effect of removing partial_clear() in test12-final.
> 
> No. If you read the code, partial_clear() has been a no-op for the
> longest time (the "start & ~PAGE_MASK" thing could never trigger, as
> "start" has been page-aligned for a long long while now.
> 
> So it must be something else.
> 
>                 Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
