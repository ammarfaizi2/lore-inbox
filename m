Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132163AbQLQDhX>; Sat, 16 Dec 2000 22:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132257AbQLQDhN>; Sat, 16 Dec 2000 22:37:13 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:55058 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S132163AbQLQDhI>; Sat, 16 Dec 2000 22:37:08 -0500
Date: Sat, 16 Dec 2000 19:05:39 -0800 (PST)
From: ferret@phonewave.net
To: Peter Samuelson <peter@cadcamlab.org>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        Dana Lacoste <dana.lacoste@peregrine.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: Linus's include file strategy redux
In-Reply-To: <20001216174351.N3199@cadcamlab.org>
Message-ID: <Pine.LNX.3.96.1001216190142.25257A-100000@tarot.mentasm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Dec 2000, Peter Samuelson wrote:

> 
> [ferret@phonewave.net]
> > Do you have an alternative reccomendation? I've shown where the
> > symlink method WILL fail. You disagree that having the configured
> > headers copied is a workable idea. What else is there?
> 
> 4.5 more megabytes, per kernel, on my root filesystem.  (That's *after*
> pruning the extra include/asm-*/'s.)  Thanks but no thanks.

Yep. Did not occur to me at the time I asked. Someone else pointed this
out to me also. VERY good point, but still needed to be explicitely
mentioned.

> Symlinks fail only if you move or delete your tree.  By doing that, you
> have proven that you actually know what and where your kernel sources
> are, which in turn is strong evidence that you are not in need of those
> "External Module Compiling for Dummies" scripts.

I have not moved or deleted a tree. I do not HAVE a kernel tree in the
first place. Therefore, nothing for the symlink to point to when I install
the kernel.

> Conversely, by actually trusting a random script to compile an external
> module unaided, the user is all but declaring himself incapable of
> messing around with the /usr/src/linux that came pre-installed.

You are assuming there is a /usr/src/linux that came pre-installed. This
is not a valid assumption.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
