Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131080AbQLQAO4>; Sat, 16 Dec 2000 19:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131129AbQLQAOf>; Sat, 16 Dec 2000 19:14:35 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:17422 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131080AbQLQAOc>; Sat, 16 Dec 2000 19:14:32 -0500
Date: Sat, 16 Dec 2000 17:43:51 -0600
To: ferret@phonewave.net
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        Dana Lacoste <dana.lacoste@peregrine.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: Linus's include file strategy redux
Message-ID: <20001216174351.N3199@cadcamlab.org>
In-Reply-To: <20001215195611.L829@nightmaster.csn.tu-chemnitz.de> <Pine.LNX.3.96.1001215193529.19208C-100000@tarot.mentasm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1001215193529.19208C-100000@tarot.mentasm.org>; from ferret@phonewave.net on Fri, Dec 15, 2000 at 07:37:49PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ferret@phonewave.net]
> Do you have an alternative reccomendation? I've shown where the
> symlink method WILL fail. You disagree that having the configured
> headers copied is a workable idea. What else is there?

4.5 more megabytes, per kernel, on my root filesystem.  (That's *after*
pruning the extra include/asm-*/'s.)  Thanks but no thanks.

Symlinks fail only if you move or delete your tree.  By doing that, you
have proven that you actually know what and where your kernel sources
are, which in turn is strong evidence that you are not in need of those
"External Module Compiling for Dummies" scripts.

Conversely, by actually trusting a random script to compile an external
module unaided, the user is all but declaring himself incapable of
messing around with the /usr/src/linux that came pre-installed.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
