Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267580AbRGXPrK>; Tue, 24 Jul 2001 11:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267582AbRGXPrA>; Tue, 24 Jul 2001 11:47:00 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:51963 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267580AbRGXPq4>;
	Tue, 24 Jul 2001 11:46:56 -0400
Date: Tue, 24 Jul 2001 11:46:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Jonathan Lundell <jlundell@pobox.com>, Jan Hubicka <jh@suse.cz>,
        linux-kernel@vger.kernel.org,
        user-mode-linux-user@lists.sourceforge.net,
        Jeff Dike <jdike@karaya.com>, Andrea Arcangeli <andrea@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: user-mode port 0.44-2.4.7
In-Reply-To: <XFMail.20010724084134.davidel@xmailserver.org>
Message-ID: <Pine.GSO.4.21.0107241141500.25475-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Tue, 24 Jul 2001, Davide Libenzi wrote:

> One more thing, with volatile you specify it one time ( declaration time ),
> while with barrier() you've to spread inside the code tons of such macro
> everywhere you touch the variable.

That's the whole point, damnit. Syntax (or semantics) sugar is a Bad Thing(tm).
If your algorithm depends on something in a nontrivial way - _spell_ _it_ _out_.

