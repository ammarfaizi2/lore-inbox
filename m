Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131134AbQLEEmn>; Mon, 4 Dec 2000 23:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131127AbQLEEmd>; Mon, 4 Dec 2000 23:42:33 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:15888 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131088AbQLEEmY>; Mon, 4 Dec 2000 23:42:24 -0500
Date: Mon, 4 Dec 2000 22:10:35 -0600
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fasttrak100 questions...
Message-ID: <20001204221035.A6567@cadcamlab.org>
In-Reply-To: <8voa7g$d1r$1@forge.tanstaafl.de> <Pine.LNX.4.21.0011291152500.5109-100000@sol.compendium-tech.com> <20001129210830.J17523@forge.tanstaafl.de> <20001129165236.A9536@vger.timpanogas.org> <3A266EE7.4C734350@nortelnetworks.com> <20001201214415.E25464@wire.cadcamlab.org> <20001203235452.C165@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001203235452.C165@bug.ucw.cz>; from pavel@suse.cz on Sun, Dec 03, 2000 at 11:54:52PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Pavel Machek]
> Hmm, add special code for GPL into gzip ;-).

Someone on debian-devel thought of this, but went one further: change
the gzip header magic so that only a "GPL-enabled" gzip can decompress
it.

I wonder how the zlib maintainers (zlib is not GPL) would feel about
having to add support for *that*. (:

> PS: That's crazy. Including it by reference should be enough. I do
> not want waste 17K on every file.

It's not crazy, it's RMS. (: I guess he is worried about some .deb file
falling into the wrong hands and being used on a system where nobody
has heard of the GPL and there is no copy available ... then the target
user won't know his or her rights and responsibilities.

Yeah, I think it's pretty far-fetched too.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
