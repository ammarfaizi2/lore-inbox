Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129871AbQKNUNd>; Tue, 14 Nov 2000 15:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129602AbQKNUNZ>; Tue, 14 Nov 2000 15:13:25 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:29196 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129551AbQKNUNM>; Tue, 14 Nov 2000 15:13:12 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: More modutils: It's probably worse.
Date: 14 Nov 2000 11:42:42 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8us4ji$dbl$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0011132040160.1699-100000@ferret.lmh.ox.ac.uk> <20001114095921.E30730@monad.caldera.de> <3A119082.BBFD700@talontech.com> <20001114152430.C2645@alcove.wittsend.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001114152430.C2645@alcove.wittsend.com>
By author:    "Michael H. Warfield" <mhw@wittsend.com>
In newsgroup: linux.dev.kernel
>
> 	Oh, I hate to add to a remark like that (OK, I lied, I love
> trollbait...)
> 
> On Tue, Nov 14, 2000 at 11:20:35AM -0800, Ben Ford wrote:
> > Olaf Kirch wrote:
> 
> > > sure request_module _does_not_ accept funky module names. Why allow
> > > people to shoot themselves (and, by extension, all other Linux users
> > > out there) in the foot?
> 
> > I thought that was the whole purpose of Unix/Linux?
> 
> 	True!  Very true!  Unix/Linux requires that the user shoot
> themselves in the foot.  Windows automates that process and does it
> for the user, thus making foot shooting user friendly.  :-)
> 

Seriously, though, I don't see any reason modprobe shouldn't accept
funky filenames.  There is a standard way to do that, which is to have
an argument consisting of the string "--"; this indicates that any
further arguments should be considered filenames and not options.

For example:

rm -- -foo		# Delete a file named "-foo"

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
