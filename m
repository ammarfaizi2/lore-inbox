Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135889AbRA1AoE>; Sat, 27 Jan 2001 19:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136079AbRA1Any>; Sat, 27 Jan 2001 19:43:54 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:19769 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S135889AbRA1Anu>; Sat, 27 Jan 2001 19:43:50 -0500
Message-ID: <3A736B3E.BEBEAC34@linux.com>
Date: Sun, 28 Jan 2001 00:43:42 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps hang in 241-pre10
In-Reply-To: <3A724FD2.3DEB44C@reptechnic.com.au> <3A7295F6.621BBEC4@Home.com> <3A731E65.8BE87D73@pobox.com> <3A7359BB.7BBEE42A@linux.com> <94voof$17j$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> In article <3A7359BB.7BBEE42A@linux.com>, David Ford  <david@linux.com>
> wrote:
> >
> >We've narrowed it down to "we're all running xmms" when it happend.
>
> Does anybody have a clue about what is different with xmms?

Not sure.


> Does it use KNI if it can, for example? We used to have a problem with
> KNI+Athlons, for example.
>
> It might also be that it's threading-related, and that XMMS is one of
> the few things that uses threads. Things like that. I'm not an XMMS
> user, can somebody who knows XMMS comment on things that it does that
> are unusual?

If I was clued enough to know KNI, I could say for a certainty.  I am
assuming it's a form of MMX or related.  My notebook is a mobile pII 366.

I'm stress testing it now with ac12.  I originally had pre9 on it.  There is
one difference other than that, I have Marcelo's bg aging patch on here which
seems to have improved responsiveness significantly but I'll save that for
another story.

I've triggered it, report follows in next email.

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
