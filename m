Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317293AbSGOAFT>; Sun, 14 Jul 2002 20:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317300AbSGOAFS>; Sun, 14 Jul 2002 20:05:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47889 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317293AbSGOAFR>; Sun, 14 Jul 2002 20:05:17 -0400
Date: Sun, 14 Jul 2002 17:10:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Paul Menage <pmenage@ensim.com>, Maneesh Soni <maneesh@in.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [RFC] dcache scalability patch (2.4.17) 
In-Reply-To: <Pine.GSO.4.21.0207130409090.13648-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0207141708470.20233-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Jul 2002, Alexander Viro wrote:
>
> So I'd just do
>
> vi fs/dcache.c -c '/|= DCACHE_R/d|/nr_un/pu|<|x'
>
> and be done with that.  Linus?

Done.

For future reference - don't anybody else try to send patches as vi
scripts, please. Yes, it's manly, but let's face it, so is bungee-jumping
with the cord tied to your testicles.

		Linus

