Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129908AbQLFDKE>; Tue, 5 Dec 2000 22:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129909AbQLFDJy>; Tue, 5 Dec 2000 22:09:54 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:37134 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129908AbQLFDJt>; Tue, 5 Dec 2000 22:09:49 -0500
Message-ID: <3A2DA6BE.B233AEF6@transmeta.com>
Date: Tue, 05 Dec 2000 18:38:54 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>,
        Alan Cox <alan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: That horrible hack from hell called A20
In-Reply-To: <Pine.LNX.4.10.10012051738310.967-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 5 Dec 2000, Linus Torvalds wrote:
> >
> > Right now this is my interim patch (to clean test11). The thing to note is
> > that I decreased the keyboard controller timeout by a factor of about 167,
> > while making the "delay" a bit longer.
> 
> Oh, btw, I forgot to ask people to give this a whirl. I assume it fixes
> the APM problems for Kai.
> 
> It definitely won't fix the silly Olivetti M4 issue (we still touch bit #2
> in 0x92). We'll need to fix that by testing A20 before bothering with the
> 0x92 stuff. Alan, that should get fixed in 2.2.x too - clearly those
> Olivetti machines can be considered buggy, but even so..
> 
> Who else had trouble with the keyboard controller?
> 

Some IBM Aptiva box...

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
