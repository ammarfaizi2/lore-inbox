Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129101AbRA2RPT>; Mon, 29 Jan 2001 12:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129235AbRA2RPJ>; Mon, 29 Jan 2001 12:15:09 -0500
Received: from vena.lwn.net ([206.168.112.25]:20239 "HELO eklektix.com")
	by vger.kernel.org with SMTP id <S129101AbRA2RPD>;
	Mon, 29 Jan 2001 12:15:03 -0500
Message-ID: <20010129171459.922.qmail@eklektix.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list (really sleep_on)
From: corbet-lk@lwn.net (Jonathan Corbet)
Date: Mon, 29 Jan 2001 10:14:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anything which uses sleep_on() has a 90% chance of being broken. Fix
> them all, because we want to remove sleep_on() and friends in 2.5.

This reminds me of a question I've been meaning to ask...

Suppose you were working on the new edition of the device drivers book,
which was just in the process of going out for tech review.  You would, of
course, have put in a lot of words about the sorts of race conditions that
can come about when sleep_on() is used.

Is that enough?  Or would you omit coverage of those functions in favor of
"doing it right" from the beginning?

Obviously, I'm thinking about ripping out much of the sleep_on() discussion
as a last-minute change.  I would be most curious to hear whether people
think that would be the right thing to do.

Thanks,

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
