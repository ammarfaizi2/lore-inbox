Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290919AbSBFXiI>; Wed, 6 Feb 2002 18:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290958AbSBFXh5>; Wed, 6 Feb 2002 18:37:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14352 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290953AbSBFXhK>; Wed, 6 Feb 2002 18:37:10 -0500
Date: Wed, 6 Feb 2002 15:36:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <3C618AFD.7148EEAA@linux-m68k.org>
Message-ID: <Pine.LNX.4.33.0202061529280.1714-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 6 Feb 2002, Roman Zippel wrote:
>
> Sorry, I meant the part about accepting patches directly from email.
> Pine supports piping a mail to a script, this script could try to apply
> the patch and extract the text in front of the patch, but it could of
> course also recognize a bk patch and feed it to bk.

That's not the problem I have.

The problem I have with piping patches directly to bk is that I don't like
to switch back-and-forth between reading email and applying (and fixing
up) patches. Even if the patch applies cleanly (which most of them tend to
do) I still usually need to do at least some minimal editing of the commit
message etc (removing stuff like "Hi Linus" etc).

So my scripts are all done to automate this, and to allow me to just save
the patches off for later, and then apply them in chunks when I'm ready to
switch over from email to tree update. So that's why I script the thing,
and want to apply patches from emails rather than by piping them.

Some of these issues don't exist with true BK patches, and I'm trying to
set up a separate chain to apply those directly (and not from the email at
all - the email would contain only a description and a BK repository
source). That will be very convenient for multiple patches, but at the
same time that will require more trust in the source, so I'll probably
keep the "patches as diffs in emails" for the occasional work, and the
direct BK link for the people I work closest with.

		Linus

