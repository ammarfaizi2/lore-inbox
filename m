Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131378AbQLFCh2>; Tue, 5 Dec 2000 21:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131377AbQLFChS>; Tue, 5 Dec 2000 21:37:18 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:32013 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131360AbQLFChC>; Tue, 5 Dec 2000 21:37:02 -0500
Message-ID: <3A2D9F03.7642B802@transmeta.com>
Date: Tue, 05 Dec 2000 18:05:55 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11-pre5 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, kai@thphy.uni-duesseldorf.de
Subject: Re: That horrible hack from hell called A20
In-Reply-To: <E143TKU-0000AS-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Okay, here is my latest attempt to find a way to toggle A20M# that
> > genuinely works on all machines -- including Olivettis, IBM Aptivas,
> > bizarre notebooks, yadda yadda.
> 
> Can I suggest a slightly different hammer. Flip the A20 via the keyboard
> controller and set the timeout to say 1 second. If that fails then kick the
> 0x92 stuff ?

I think that's pretty much the one remaining plan.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
