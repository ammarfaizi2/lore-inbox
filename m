Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267843AbRGXQJA>; Tue, 24 Jul 2001 12:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267862AbRGXQIu>; Tue, 24 Jul 2001 12:08:50 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:42902 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267843AbRGXQIo>;
	Tue, 24 Jul 2001 12:08:44 -0400
Date: Tue, 24 Jul 2001 12:08:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
        Jeff Dike <jdike@karaya.com>,
        user-mode-linux-user@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Jan Hubicka <jh@suse.cz>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: user-mode port 0.44-2.4.7
In-Reply-To: <XFMail.20010724090137.davidel@xmailserver.org>
Message-ID: <Pine.GSO.4.21.0107241203260.25475-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Tue, 24 Jul 2001, Davide Libenzi wrote:

> I would not call, to pretend the compiler to issue memory loads every time it access
> a variable, a nontrivial way.
> It sounds pretty clear to me.

You know, one of the nice things about C is that unless you abuse
preprocessor, reading code doesn't require doing far lookups. Most
of it can be read and understood with very little context. "Do it
once when you declare a variable" goes against that and that's
not a good thing.

