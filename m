Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262382AbTCIDIi>; Sat, 8 Mar 2003 22:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262383AbTCIDIi>; Sat, 8 Mar 2003 22:08:38 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:19461 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262382AbTCIDIh>; Sat, 8 Mar 2003 22:08:37 -0500
Date: Sun, 9 Mar 2003 04:19:05 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Zack Brown <zbrown@tumblerings.org>
cc: Larry McVoy <lm@work.bitmover.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
In-Reply-To: <20030309024522.GA25121@renegade>
Message-ID: <Pine.LNX.4.44.0303090401160.32518-100000@serv>
References: <200303020011.QAA13450@adam.yggdrasil.com>
 <20030307123237.GG18420@atrey.karlin.mff.cuni.cz> <20030307165413.GA78966@dspnet.fr.eu.org>
 <20030307190848.GB21023@atrey.karlin.mff.cuni.cz> <b4b98v$14m$1@penguin.transmeta.com>
 <20030308225252.GA23972@renegade> <20030309000514.GB1807@work.bitmover.com>
 <20030309024522.GA25121@renegade>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 8 Mar 2003, Zack Brown wrote:

>   * Distributed rename handling. Centralized systems like Subversion don't
>   have as many problems with this because you can only create one file in
>   one directory entry because there is only one directory entry available.
>   In distributed rename handling, there can be an infinite number of different
>   files which all want to be src/foo.c. There are also many rename corner-cases.

This actually a very bk specific problem, because the real problem under 
bk there can be only one src/SCCS/s.foo.c. A separate repository doesn't 
have this problem, because it has control over the naming in the 
repository and the original naming is restored with an explicit checkout.
In this context it will be really interesting to see how Larry wants to 
implement "lines of development" (aka branches which don't suck) and 
also maintain SCCS compatibility.

bye, Roman

