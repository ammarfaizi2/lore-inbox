Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKKDED>; Fri, 10 Nov 2000 22:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129316AbQKKDDx>; Fri, 10 Nov 2000 22:03:53 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:39686 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129057AbQKKDDn>; Fri, 10 Nov 2000 22:03:43 -0500
Message-ID: <3A0CB6FD.D4CCE09F@transmeta.com>
Date: Fri, 10 Nov 2000 19:03:25 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Max Inux <maxinux@bigfoot.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
In-Reply-To: <Pine.LNX.4.30.0011101822120.10847-100000@shambat>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Inux wrote:
> 
> On 10 Nov 2000, H. Peter Anvin wrote:
> >Different compile options?
> >
> >Why is a 900K kernel unusable?
> >
> >       -hpa
> 
> My guess would be it not actually bzipping the kernel.  Id run make
> bzImage again and making sure  it is bzipping it.
> 

gzip, actually.  I can verify here "make bzImage" does the expected thing
and it looks normal-sized to me.

> 
> On x86 machines there is a size limitation on booting.  Though I thought
> it was 1024K as the max, 900K should be fine.
> 

No, there isn't.  There used to be, but it has been fixed.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
