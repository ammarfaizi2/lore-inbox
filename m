Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132569AbRAUB3q>; Sat, 20 Jan 2001 20:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133084AbRAUB3f>; Sat, 20 Jan 2001 20:29:35 -0500
Received: from shell.ca.us.webchat.org ([216.152.64.152]:50066 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S132569AbRAUB3b>; Sat, 20 Jan 2001 20:29:31 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Michael Lindner" <mikel@att.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: select() on TCP socket sleeps for 1 tick even if data   available
Date: Sat, 20 Jan 2001 17:29:29 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKOELMNCAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3A6A39D0.E6E76CD3@att.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ...and I still don't understand why the identical program, but using one
> socket instead of 2 sockets, IS CPU bound, and gets on the order of
> 10K/sec. on the same HW. Diffs to produce 10K/sec. 1 socket version from
> my previous sample follow...

	It's really this simple -- this isn't what TCP is intended for.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
