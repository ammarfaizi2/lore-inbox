Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278450AbRKMTMw>; Tue, 13 Nov 2001 14:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278309AbRKMTMk>; Tue, 13 Nov 2001 14:12:40 -0500
Received: from mail311.mail.bellsouth.net ([205.152.58.171]:59552 "EHLO
	imf11bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S278313AbRKMTMQ>; Tue, 13 Nov 2001 14:12:16 -0500
Message-ID: <3BF1707A.B8AA4F2D@mandrakesoft.com>
Date: Tue, 13 Nov 2001 14:11:54 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reformat mtrr.c to conform to CodingStyle
In-Reply-To: <20011112232539.A14409@redhat.com> <Pine.LNX.4.33.0111130903350.16316-100000@penguin.transmeta.com> <20011114080505.A18098@weta.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> On Tue, Nov 13, 2001 at 09:04:33AM -0800, Linus Torvalds wrote:
> 
>     I don't like reformatting without at least asking the maintainer,
>     unless the maintainer isn't doing maintenance. Also, right now I'd
>     rather not have any big patches even if they are just
>     syntactic.. Makes hand-over to Marcelo simpler.
> 
> If (at some point) people do want coding-style patches then there are
> MANY places (eg. entire filesystem sub-trees) which could have
> white-space alignment changes and similar things....


True.  For mtrr.c it (a) is unmaintained for years, and (b) is actively
being hacked on by non-maintainers.

It has an especially strong case for Lindent'ing.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

