Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136969AbRA1JAM>; Sun, 28 Jan 2001 04:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136970AbRA1JAD>; Sun, 28 Jan 2001 04:00:03 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:36495 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S136969AbRA1I7m>; Sun, 28 Jan 2001 03:59:42 -0500
Date: Sun, 28 Jan 2001 08:59:30 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ps hang in 241-pre10
In-Reply-To: <94voof$17j$1@penguin.transmeta.com>
Message-ID: <Pine.SOL.4.21.0101280856380.14226-100000@green.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Jan 2001, Linus Torvalds wrote:

> In article <3A7359BB.7BBEE42A@linux.com>, David Ford  <david@linux.com>
> wrote:
> >
> >We've narrowed it down to "we're all running xmms" when it happend.
> 
> Does anybody have a clue about what is different with xmms?
> 
> Does it use KNI if it can, for example? We used to have a problem with
> KNI+Athlons, for example. 

Not KNI, I don't think, but 1.2.4 did add support for 3dnow!, with
auto-detection of CPU type. Disabled by default, but available. Are there
any 3dnow! issues??

> It might also be that it's threading-related, and that XMMS is one of
> the few things that uses threads. Things like that. I'm not an XMMS
> user, can somebody who knows XMMS comment on things that it does that
> are unusual?

Always uses threads, can use 3dnow!, DGA and realtime priority. Can also
do direct hardware access to some graphics cards (inc SB16), but I haven't
looked at that one closely.


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
