Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbUJZCUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbUJZCUa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 22:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbUJZCUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:20:25 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:35986 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262171AbUJZCTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 22:19:22 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrea Arcangeli <andrea@novell.com>, Linus Torvalds <torvalds@osdl.org>,
       Joe Perches <joe@perches.com>, Larry McVoy <lm@work.bitmover.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
References: <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org>
	<20041023161253.GA17537@work.bitmover.com>
	<4d8e3fd304102403241e5a69a5@mail.gmail.com>
	<20041024144448.GA575@work.bitmover.com>
	<4d8e3fd304102409443c01c5da@mail.gmail.com>
	<20041024233214.GA9772@work.bitmover.com>
	<20041025114641.GU14325@dualathlon.random>
	<1098707342.7355.44.camel@localhost.localdomain>
	<20041025133951.GW14325@dualathlon.random>
	<Pine.LNX.4.58.0410250812300.3016@ppc970.osdl.org>
	<20041025154318.GA14325@dualathlon.random>
	<417D5C31.8000806@pobox.com>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Tue, 26 Oct 2004 11:19:04 +0900
In-Reply-To: <417D5C31.8000806@pobox.com> (Jeff Garzik's message of "Mon, 25
 Oct 2004 16:04:01 -0400")
Message-ID: <buoekjm8bmv.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:
>> arch exists and it's exactly as distributed as BK.
>
> It doesn't scale or merge as well as BK though.

Examples?

Scalability I'm not sure about; BK's "you must inform BK before you
change a file" model gives it a potential for being very quick at
"tree-compare" operations -- but makes it more annoying for the user.

Merging also seems a bit hard to judge.  From what I understand of BK,
it has a much more limited merging model than arch does; to do a
reasonable comparison, you'd have to see how well arch did if you
limited yourself to that restricted model, and then give arch some more
points for not forcing you to do so.

BK no doubt wins on the rough-edges-sanded-down front though; there are
a _few_ advantages to commercial software...

-Miles
-- 
97% of everything is grunge
