Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131228AbQKHCZD>; Tue, 7 Nov 2000 21:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131232AbQKHCYx>; Tue, 7 Nov 2000 21:24:53 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:57869 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131228AbQKHCYr>; Tue, 7 Nov 2000 21:24:47 -0500
Message-ID: <3A08B95B.3D473A5F@transmeta.com>
Date: Tue, 07 Nov 2000 18:24:27 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Igmar Palsenberg <maillist@chello.nl>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: xterm: no available ptys
In-Reply-To: <Pine.LNX.4.21.0011080131200.32613-100000@server.serve.me.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Igmar Palsenberg wrote:
> 
> > > I'm missing ptmx. You NEED a writable /dev/pts dir.
> > >
> >
> > Actually, what you need is the devpts filesystem mounted onto
> > /dev/pts.
> 
> Agree. I had a shitload of probs when 2.2.0 came out and I switched.. Was
> due that /dev was readonly here. Bit strange if I think of it.
> 

If you don't have devpts mounted, glibc tries to use a setuid program to
hack around /dev for you.  I'd rather wish it didn't, actually.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
