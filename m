Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131511AbRA1AXV>; Sat, 27 Jan 2001 19:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131640AbRA1AXM>; Sat, 27 Jan 2001 19:23:12 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:14858 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131511AbRA1AXB>; Sat, 27 Jan 2001 19:23:01 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: ps hang in 241-pre10
Date: 27 Jan 2001 16:22:39 -0800
Organization: Transmeta Corporation
Message-ID: <94voof$17j$1@penguin.transmeta.com>
In-Reply-To: <3A724FD2.3DEB44C@reptechnic.com.au> <3A7295F6.621BBEC4@Home.com> <3A731E65.8BE87D73@pobox.com> <3A7359BB.7BBEE42A@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A7359BB.7BBEE42A@linux.com>, David Ford  <david@linux.com>
wrote:
>
>We've narrowed it down to "we're all running xmms" when it happend.

Does anybody have a clue about what is different with xmms?

Does it use KNI if it can, for example? We used to have a problem with
KNI+Athlons, for example. 

It might also be that it's threading-related, and that XMMS is one of
the few things that uses threads. Things like that. I'm not an XMMS
user, can somebody who knows XMMS comment on things that it does that
are unusual?

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
