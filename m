Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129859AbRAIWeJ>; Tue, 9 Jan 2001 17:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129835AbRAIWd7>; Tue, 9 Jan 2001 17:33:59 -0500
Received: from [216.151.155.116] ([216.151.155.116]:11789 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S129859AbRAIWdo>; Tue, 9 Jan 2001 17:33:44 -0500
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org, shane@agendacomputing.com
Subject: Re: [PATCH] cramfs is ro only, so honour this in inode->mode
In-Reply-To: <200101092203.f09M3oY327528@saturn.cs.uml.edu>
From: Doug McNaught <doug@wireboard.com>
Date: 09 Jan 2001 17:33:29 -0500
In-Reply-To: "Albert D. Cahalan"'s message of "Tue, 9 Jan 2001 17:03:50 -0500 (EST)"
Message-ID: <m3ae90uzie.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

> Doug writes:
> > bash-2.03$ cd /tmp
> > bash-2.03$ cat >foo
> > This is a test.
> > bash-2.03$ chmod u-r foo
> 
> No, you zeroed the owner's read bit. When the bit isn't
> implemented it must be always set.
> 
> By "(owner may read own files)" I refer to what happens
> after you steal the bit, causing it to always appear set.

Ahh, OK, thanks for the clarification.

-Doug
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
