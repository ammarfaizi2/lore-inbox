Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278271AbRJMFqN>; Sat, 13 Oct 2001 01:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278272AbRJMFqE>; Sat, 13 Oct 2001 01:46:04 -0400
Received: from s1.relay.oleane.net ([195.25.12.48]:29931 "HELO
	s1.relay.oleane.net") by vger.kernel.org with SMTP
	id <S278271AbRJMFp4>; Sat, 13 Oct 2001 01:45:56 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: <linux-kernel@vger.kernel.org>, Mike Borrelli <mike@nerv-9.net>
Subject: Re: No love for the PPC
Date: Sat, 13 Oct 2001 07:46:15 +0200
Message-Id: <20011013054615.1831@smtp.adsl.oleane.com>
In-Reply-To: <200110130452.f9D4qG9288830@saturn.cs.uml.edu>
In-Reply-To: <200110130452.f9D4qG9288830@saturn.cs.uml.edu>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>At the most recent Ottata Linux Symposium, there was a PowerPC
>session with about 20 people. Somebody did a poll, asking what
>people used. I was the only person who dared to use a kernel
>from Linus. Everone else was using the BenH and BitKeeper ones.
>
>This is a sorry state of affairs. If people are off using kernels
>from other places, there isn't a great incentive to keep the
>official Linus kernel updated. Nobody uses it anyway.
>
>Elimination of these non-Linus PowerPC trees would be great.
>(at least the "stable" ones should go, as they lure people
>away from the one true source tree)

That's not exactly how things happen.

Most users use the kernel that comes with their distro, which,
as usual in the linux world, is made of bits from here and there.

Some mac users use my kernels because they contain some bleeding
edge stuff that is not ready to be in a stable tree. It's an
experimental kernel and doesn't claim to be stable.

Now, PPC is a lot of very different machines, coordinating them
all is a complicated task, and having our own tree to handle the
merge work is pretty useful. This is the bk _2_4 "stable" tree, any
thing in there is supposed to be "pending" for Linus.

We would probably be happy to submit all what we have in _2_4_devel
once 2.5 is opened. It's our developemental tree. Occasionally,
parts of it are considered stable enough to get to _2_4, and
at that point, it might happen to take some time before beeing
fully merged in Linus tree, but we are doing our best.

Ben.


