Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267584AbRGXP6b>; Tue, 24 Jul 2001 11:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267619AbRGXP6U>; Tue, 24 Jul 2001 11:58:20 -0400
Received: from sncgw.nai.com ([161.69.248.229]:48883 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S267584AbRGXP6N>;
	Tue, 24 Jul 2001 11:58:13 -0400
Message-ID: <XFMail.20010724090137.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.GSO.4.21.0107241141500.25475-100000@weyl.math.psu.edu>
Date: Tue, 24 Jul 2001 09:01:37 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: user-mode port 0.44-2.4.7
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
        Jeff Dike <jdike@karaya.com>,
        user-mode-linux-user@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Jan Hubicka <jh@suse.cz>,
        Jonathan Lundell <jlundell@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On 24-Jul-2001 Alexander Viro wrote:
> 
> 
> On Tue, 24 Jul 2001, Davide Libenzi wrote:
> 
>> One more thing, with volatile you specify it one time ( declaration time ),
>> while with barrier() you've to spread inside the code tons of such macro
>> everywhere you touch the variable.
> 
> That's the whole point, damnit. Syntax (or semantics) sugar is a Bad Thing(tm).
> If your algorithm depends on something in a nontrivial way - _spell_ _it_ _out_.

I would not call, to pretend the compiler to issue memory loads every time it access
a variable, a nontrivial way.
It sounds pretty clear to me.




- Davide

