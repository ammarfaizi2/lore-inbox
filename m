Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280663AbRKNPbA>; Wed, 14 Nov 2001 10:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280647AbRKNPaw>; Wed, 14 Nov 2001 10:30:52 -0500
Received: from mail100.mail.bellsouth.net ([205.152.58.40]:3327 "EHLO
	imf00bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280655AbRKNPao>; Wed, 14 Nov 2001 10:30:44 -0500
Message-ID: <3BF28E0C.C32ACD63@mandrakesoft.com>
Date: Wed, 14 Nov 2001 10:30:20 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@idb.hist.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reformat mtrr.c to conform to CodingStyle
In-Reply-To: <20011112232539.A14409@redhat.com> <Pine.LNX.4.33.0111130903350.16316-100000@penguin.transmeta.com> <20011114080505.A18098@weta.f00f.org> <3BF24AB2.1C8232C0@idb.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> Chris Wedgwood wrote:
> 
> > If (at some point) people do want coding-style patches then there are
> > MANY places (eg. entire filesystem sub-trees) which could have
> > white-space alignment changes and similar things....
> 
> Creating lots of such patches looks like unnecessary work to me.
> Why not let Linus run Lindent on the whole tree and be done with it?
> find linux/ -name "*.[ch]" | linux/scripts/Lindent

Lindent still does a few dumb things which make me review the code after
formatting and before submission...

Also, Christoph Hellewig ported NetBSD's indent, which is supposedly a
bit better overall than GNU indent. Something else to look into.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

