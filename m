Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132145AbRACGYB>; Wed, 3 Jan 2001 01:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132223AbRACGXw>; Wed, 3 Jan 2001 01:23:52 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:6924 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132145AbRACGXe>; Wed, 3 Jan 2001 01:23:34 -0500
Date: Tue, 2 Jan 2001 21:52:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Anton Blanchard <anton@linuxcare.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: scheduling problem?
In-Reply-To: <Pine.Linu.4.10.10101030546500.1057-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.10.10101022151430.24870-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jan 2001, Mike Galbraith wrote:
> 
> No difference (except more context switching as expected)

What about the current prerelese patch in testing? It doesn't switch to
bdflush at all, but instead does the buffer cleaning by hand.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
