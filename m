Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129835AbRAJAUE>; Tue, 9 Jan 2001 19:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130177AbRAJATy>; Tue, 9 Jan 2001 19:19:54 -0500
Received: from tahallah.claranet.co.uk ([212.126.138.206]:23302 "EHLO
	tahallah.clara.co.uk") by vger.kernel.org with ESMTP
	id <S129903AbRAJATl>; Tue, 9 Jan 2001 19:19:41 -0500
Date: Wed, 10 Jan 2001 00:19:33 +0000 (GMT)
From: Alex Buell <alex.buell@tahallah.clara.co.uk>
X-X-Sender: <alex@tahallah.clara.co.uk>
Reply-To: <alex.buell@tahallah.clara.co.uk>
To: Robert Kaiser <rob@sysgo.de>
cc: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Anybody got 2.4.0 running on a 386 ?
In-Reply-To: <01011001040704.03050@rob>
Message-ID: <Pine.LNX.4.31.0101100016330.4819-100000@tahallah.clara.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, Robert Kaiser wrote:

> I have put a "halting statement" (i.e. "while(1);") after my printouts
> to make sure execution does not go any further than that point. I
> moved this halting statement ahead in the code line by line until the
> crash would occur again. So, yes, I am pretty sure.

Here's a tip for anyone who has to track down bugs of this nature. To
greatly speed up work, just use a binary search technique. That is, go to
the section of code that's causing problem, put a breakpoint or similiar
half-way. If it dies before that point, move it back half way, after that
point, move it forwards half way. Iterate until you find the place.

Cheers,
Alex
-- 
If PacMan had affected us as kids we'd be running around in
dark rooms, munching pills and listening to electronic music.

http://www.tahallah.clara.co.uk

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
