Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbVA0QzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbVA0QzU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbVA0QyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:54:15 -0500
Received: from zeus.kernel.org ([204.152.189.113]:54992 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262577AbVA0QwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:52:13 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: thoughts on kernel security issues
Date: Thu, 27 Jan 2005 10:37:46 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-os <linux-os@analogic.com>,
       John Richard Moser <nigelenki@comcast.net>, dtor_core@ameritech.net,
       Linus Torvalds <torvalds@osdl.org>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1050126143205.24013A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1050126143205.24013A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Message-Id: <05012710374600.20895@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 January 2005 13:56, Bill Davidsen wrote:
> On Wed, 26 Jan 2005, Jesse Pollard wrote:
> > On Tuesday 25 January 2005 15:05, linux-os wrote:
> > > This isn't relevant at all. The Navy doesn't have any secure
> > > systems connected to a network to which any hackers could connect.
> > > The TDRS communications satellites provide secure channels
> > > that are disassembled on-board. Some ATM-slot, after decryption
> > > is fed to a LAN so the sailors can have an Internet connection
> > > for their lap-tops. The data took the same paths, but it's
> > > completely independent and can't get mixed up no matter how
> > > hard a hacker tries.
> >
> > Obviously you didn't hear about the secure network being hit by the "I
> > love you" virus.
> >
> > The Navy doesn't INTEND to have any secure systems connected to a network
> > to which any hackers could connect.
>
> What's hard about that? Matter of physical network topology, absolutely no
> physical connection, no machines with a 2nd NIC, no access to/from I'net.
> Yes, it's a PITA, add logging to a physical printer which can't be erased
> if you want to make your CSO happy (corporate security officer).

And you are ASSUMING the connection was authorized. I can assure you that 
there are about 200 (more or less) connections from the secure net to the
internet expressly for the purpose of transferring data from the internet
to the secure net for analysis. And not ALL of these connections are 
authorized. Some are done via sneakernet, others by running a cable ("I need
the data NOW... I'll just disconnect afterward..."), and are not visible
for very long. Other connections are by picking up a system and carrying it
from one connection to another (a version of sneakernet, though here it
sometimes needs a hand cart).

> > Unfortunately, there will ALWAYS be a path, either direct, or indirect
> > between the secure net and the internet.
>
> Other than letting people use secure computers after they have seen the
> Internet, a good setup has no indirect paths.

Ha. Hahaha...

Reality bites.

> > The problem exists. The only to protect is to apply layers of protection.
> >
> > And covering the possible unknown errors is a good way to add protection.
