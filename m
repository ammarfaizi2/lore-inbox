Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281739AbRLBS1M>; Sun, 2 Dec 2001 13:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281762AbRLBS1C>; Sun, 2 Dec 2001 13:27:02 -0500
Received: from waste.org ([209.173.204.2]:12439 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S281739AbRLBS0n>;
	Sun, 2 Dec 2001 13:26:43 -0500
Date: Sun, 2 Dec 2001 12:26:33 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <3C0A70DE.65F54283@mandrakesoft.com>
Message-ID: <Pine.LNX.4.40.0112021223030.28065-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Dec 2001, Jeff Garzik wrote:

> Oliver Xymoron wrote:
> >
> > And it's practically obsolete itself, outside of the ARM directory. What
> > I'm proposing is something in the Code Maturity menu that's analogous to
> > EXPERIMENTAL along with a big (UNMAINTAINED) marker next to unmaintained
> > drivers. Obsolete and unmaintained and deprecated all mean slightly
> > different things, by the way. So the config option would probably say
> > 'Show obsolete, unmaintained, or deprecated items?' and mark each item
> > appropriately. Anything that no one made a fuss about by 2.7 would be
> > candidates for removal.
>
> The idea behind CONFIG_OBSOLETE is supposed to be that it does not
> actually appear as a Y/N option.  You enclose a Config.in option with
> that, and it disappears

Which works for stuff that is really known broken. It doesn't work for
stuff that you'd like to get rid of but you suspect people may still be
using (sbpcd) or stuff that you want to phase out (initrd).

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

