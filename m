Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291771AbSBNQYX>; Thu, 14 Feb 2002 11:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291767AbSBNQYH>; Thu, 14 Feb 2002 11:24:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53771 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291752AbSBNQXx>; Thu, 14 Feb 2002 11:23:53 -0500
Date: Thu, 14 Feb 2002 08:23:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: bert hubert <ahu@ds9a.nl>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.5-pre1
In-Reply-To: <20020214090401.A8296@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.33.0202140816220.12749-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Feb 2002, bert hubert wrote:
>
> Did you always merge this many patches, or does it just look like more using
> this very nice changelog format? Anyhow, I'm impressed about the amount of
> work accepted in such a short time.

It looks like more because of the changelog format.

The old changelogs were one-liners, and didn't mention small patches at
all (ie the entries like "Remove warning in /proc inode conversions" would
not even have made it into the changelog before).

Also, I used to combine entries from the same person, so the eight patches
for reiserfs would have been one entry ("reiserfs update"), and the 20
entries from Jeff would likewise have been just one entry ("update network
drivers").

That said, this week I've basically spent _only_ on making sure I work
well with BitKeeper (so far so good), so I have spent more time than I
normally do on merging. So yes, it's actually more merging too. That will
calm down eventually.

(The happy news is that I expected to be slowed down by BK for a while,
and that hasn't really happened. Some things take more effort now, but to
offset that some other stuff is _much_ easier, so..)

		Linus

