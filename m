Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282241AbRKWUpX>; Fri, 23 Nov 2001 15:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282242AbRKWUpN>; Fri, 23 Nov 2001 15:45:13 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:45778 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S282241AbRKWUpH>;
	Fri, 23 Nov 2001 15:45:07 -0500
Date: Fri, 23 Nov 2001 21:45:00 +0100
From: David Weinehall <tao@acc.umu.se>
To: Padraig Brady <padraig@antefacto.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] remove trailing whitespace
Message-ID: <20011123214500.A5770@khan.acc.umu.se>
In-Reply-To: <Pine.LNX.4.10.10111231440260.1920-100000@coffee.psychology.mcmaster.ca> <3BFEB2DC.6040208@antefacto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3BFEB2DC.6040208@antefacto.com>; from padraig@antefacto.com on Fri, Nov 23, 2001 at 08:34:36PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 08:34:36PM +0000, Padraig Brady wrote:
> I used sed, but yes the following does
> the same as downloading and applying the patch:
> find linux -type f | xargs perl -wi -pe 's/[<space><tab>]+$//'
> (obviously replace <space> & <tab> with the appropriate chars).
> 
> Note also that after (bz2) compression the space saving drops
> from 224,654 to 139,669 bytes, which is still good.
> 
> Padraig.

Running Lindent on the kerneltree would be far more yielding, as
it would, apart from removing extraoneous whitespace, also format
all code in a sane manner. However, this is unlikely to ever happen; I
seem to recall that Linus has commented on this before.


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
