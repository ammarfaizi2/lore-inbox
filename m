Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbVAZP3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbVAZP3q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 10:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbVAZP3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 10:29:45 -0500
Received: from zeus.kernel.org ([204.152.189.113]:51367 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262329AbVAZP3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 10:29:42 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: linux-os <linux-os@analogic.com>,
       John Richard Moser <nigelenki@comcast.net>
Subject: Re: thoughts on kernel security issues
Date: Wed, 26 Jan 2005 09:15:15 -0600
X-Mailer: KMail [version 1.2]
Cc: dtor_core@ameritech.net, Linus Torvalds <torvalds@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1106157152.6310.171.camel@laptopd505.fenrus.org> <41F6A45D.1000804@comcast.net> <Pine.LNX.4.61.0501251542290.8986@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0501251542290.8986@chaos.analogic.com>
MIME-Version: 1.0
Message-Id: <05012609151500.16556@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 January 2005 15:05, linux-os wrote:
> On Tue, 25 Jan 2005, John Richard Moser wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
[snip]
> > In this context, it doesn't make sense to deploy a protection A or B
> > without the companion protection, which is what I meant.  You're
> > thinking of fixing specific bugs; this is good and very important (as
> > effective proactive security BREAKS things that are buggy), but there is
> > a better way to create a more secure environment.  Fixing the bugs
> > increases the quality of the product, while adding protections makes
> > them durable enough to withstand attacks targetting their own flaws.
>
> Adding protections for which no known threat exists is a waste of
> time, effort, and adds to the kernel size. If you connect a machine
> to a network, it can always get hit with so many broadcast packets
> that it has little available CPU time to do useful work. Do we
> add a network throttle to avoid this? If so, then you will hurt
> somebody's performance on a quiet network. Everything done in
> the name of "security" has its cost. The cost is almost always
> much more than advertised or anticipated.
>
> > Try reading through (shameless plug)
> > http://www.ubuntulinux.org/wiki/USNAnalysis and then try to understand
> > where I'm coming from.
>
> This isn't relevant at all. The Navy doesn't have any secure
> systems connected to a network to which any hackers could connect.
> The TDRS communications satellites provide secure channels
> that are disassembled on-board. Some ATM-slot, after decryption
> is fed to a LAN so the sailors can have an Internet connection
> for their lap-tops. The data took the same paths, but it's
> completely independent and can't get mixed up no matter how
> hard a hacker tries.

Obviously you didn't hear about the secure network being hit by the "I love 
you" virus.

The Navy doesn't INTEND to have any secure systems connected to a network to 
which any hackers could connect.

Unfortunately, there will ALWAYS be a path, either direct, or indirect between
the secure net and the internet.

The problem exists. The only to protect is to apply layers of protection.

And covering the possible unknown errors is a good way to add protection.
