Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318018AbSG2A2i>; Sun, 28 Jul 2002 20:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318019AbSG2A2i>; Sun, 28 Jul 2002 20:28:38 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11529 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318018AbSG2A2d>; Sun, 28 Jul 2002 20:28:33 -0400
Date: Sun, 28 Jul 2002 17:33:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries.Brouwer@cwi.nl
cc: axboe@suse.de, <linux-kernel@vger.kernel.org>, <martin@dalecki.de>
Subject: Re: [PATCH] 2.5.28 small REQ_SPECIAL abstraction
In-Reply-To: <UTC200207282359.g6SNxgW24418.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0207281725110.8208-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Jul 2002 Andries.Brouwer@cwi.nl wrote:
>
> In the absence of a single active maintainer, peer review is a
> good alternative.

I agree, but you still want to have somebody who actually steps up to the
plate after the peer review has taken place, and sends me the patch..

And yes, if it's not one of the regular lieutenants, that does mean that
me applying it will depend a bit more on just how much time I have. I
would obviously prefer that the SCSI maintainer wouldn't necessarily sync
directly with me, but with somebody I work with anyway - as long as it's
reasonably timely.

(The _good_ news is that there haven't actually been all that many reasons
to maintain SCSI for a while - most of the maintenance has actually been
due to the generic block layer changes, which Jens has naturally been very
good about. The rest has _mostly_ been about updating specific drivers to
the PCI DMA interface (and various one-liners for the block layer
changes).

> [By the way, have you asked these people to be maintainer?
> Many people are too modest to suggest themselves, but will
> accept when asked.]

Jens is actually documented as being the SCSI maintainer, but that is
probably because he is the block device maintainer and he ended up
maintaining the more fundamental changes. I've seen James Bottomley more
as the "change SCSI internals" guy, and Doug mentioned that he will have
more time to work on 2.5.x not that long ago, so I do think all three
consider themselves at least partial maintainers already.

I certainly take patches from all three (see above on whether this is
optimal for me, though ;)

		Linus

