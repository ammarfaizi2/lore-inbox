Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129692AbRAIM5H>; Tue, 9 Jan 2001 07:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129710AbRAIM44>; Tue, 9 Jan 2001 07:56:56 -0500
Received: from smtprelay.abs.adelphia.net ([64.8.20.11]:49605 "EHLO
	smtprelay1.abs.adelphia.net") by vger.kernel.org with ESMTP
	id <S129692AbRAIM4m>; Tue, 9 Jan 2001 07:56:42 -0500
Date: Tue, 9 Jan 2001 08:57:15 -0500 (EST)
From: "Steven N. Hirsch" <shirsch@adelphia.net>
To: Helge Hafting <helgehaf@idb.hist.no>
cc: Nicolas Noble <Pixel@the-babel-tower.nobis.phear.org>,
        linux-kernel@vger.kernel.org
Subject: Re: kernel network problem ?
In-Reply-To: <3A5ADBC7.D297CFDB@idb.hist.no>
Message-ID: <Pine.LNX.4.21.0101090853250.27322-100000@pii.fast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Helge Hafting wrote:

> Nicolas Noble wrote:
> [...]
> As others have told already, this is the ECN problem.
> 
> > I noticed the same bug. This is very weired, I can send a list of sites
> > which I can't connect anymore. 
> 
> You have a list?  Send all of them a message stating that they ought
> to upgrade their firewalls which cause this problem.  Or they
> will loose customers/visitors.  Cisco already have an upgrade for them,
> so fixing is dead easy, and they can then boast compatibility with
> the latest internet standards.  
> 
> If they don't care about linux users, tell them that windows eventually
> will use ECN too.  They definitely don't want to have a ECN problem when
> that happens.

After upgrading to kernel 2.4.0, I found myself unable to retrieve mail
from Adelphia's (2-way cable ISP) POP server.  It took several days to
figure out that _one_ of their routers was configured to block ECN.  After
bringing this to the attention of their network engineers, I was informed
that their policy prohibits making any router changes on the basis of one
trouble report.  The person I spoke with did NOT try to defend their
setup, but it was made clear that they'll do nothing until Windows breaks.

If I were packaging a Linux distribution, I'd be sure to have ECN disabled
by default, FWIW.

Steve


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
