Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129784AbQLOADf>; Thu, 14 Dec 2000 19:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131370AbQLOAD0>; Thu, 14 Dec 2000 19:03:26 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:14087 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129784AbQLOADQ>; Thu, 14 Dec 2000 19:03:16 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: test13-pre1 changelog
Date: 14 Dec 2000 15:31:54 -0800
Organization: Transmeta Corporation
Message-ID: <91bl9a$cc4$1@penguin.transmeta.com>
In-Reply-To: <3A392852.B9B64C7F@the-rileys.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A392852.B9B64C7F@the-rileys.net>,
David Riley  <oscar@the-rileys.net> wrote:
>Did I miss a post from Linus on the list, or is there no posted
>changelog for test13-pre1?  Nothing's posted at kernel.org yet, either.

The test13-pre1 changes are almost exclusively a radical Makefile
cleanup, and it's been discussed mainly on the kbuild mailing list.  It
doesn't actually contain any actual _code_ changes apart from some very
minor details (one of which was the "swapoff()" fix, but I doubt
"swapoff()" not working is all that big of an issue)

I'm hoping that most of the fall-out from switching over exclusively to
the new-style Makefiles will be over in a day or two, at which point
I'll make a pre2 that is worth announcing.

Especially if we get that netfilter problem sorted out (see the other
thread about the IP fragmentation issues associated with that one), and
if we figure out why apparently some people have trouble with external
modules (at least one person has trouble with loading alsa modules). 

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
