Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131742AbRA0HDv>; Sat, 27 Jan 2001 02:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130766AbRA0HDl>; Sat, 27 Jan 2001 02:03:41 -0500
Received: from femail2.rdc1.on.home.com ([24.2.9.89]:38353 "EHLO
	femail2.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S131742AbRA0HDb>; Sat, 27 Jan 2001 02:03:31 -0500
Message-ID: <3A7272AB.470F6007@Home.com>
Date: Sat, 27 Jan 2001 02:03:07 -0500
From: Shawn Starr <Shawn.Starr@Home.com>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: John Sheahan <john@reptechnic.com.au>, linux-kernel@vger.kernel.org
Subject: Re: ps hang in 241-pre10
In-Reply-To: <3A724FD2.3DEB44C@reptechnic.com.au> <20010126204324.B10046@vitelus.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed this problem in 2.4.1-pre8.

Odd, thats EXACLY what happened to me. I had to do a hard restart as killall
locked when i tried to kill ps.

Any word on why this is happening?


Aaron Lehmann wrote:

> On Sat, Jan 27, 2001 at 03:34:26PM +1100, John Sheahan wrote:
> > Hi
> > my box has been running 2.4.1-pre10 for three days.
> > This morning I noticed odd behavioue - ps and top wouuld freeze
> > with no output.
>
> I had the same problem with 2.4.1-pre10 and the zerocopy patchset.
> I came home one day and xmms was frozen. Attempting to determine
> whether it was stuck in an odd state, I ran ps aux. At a certain
> point (presumably just when it started trying to print info about the
> xmms process), ps froze up too. And any attempts to killall -9 these
> processes made the killall freeze!
>
> I'm not sure what made xmms freeze up in the first place. My first
> though was a problem in the zerocopy patchset -- most of my mp3s are
> played over NFS. However, XMMS was completely idle during the time I
> was away from the computer, so I'm not sure what caused it. It seemed
> clear, however, that the problem was contagious between processes.
>
> I reverted back to 2.4.0-ac7 and have not had any more problems of this
> nature.
>
>   ------------------------------------------------------------------------
>    Part 1.2Type: application/pgp-signature

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
