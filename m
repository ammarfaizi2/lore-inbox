Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293525AbSBZFTL>; Tue, 26 Feb 2002 00:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293523AbSBZFTD>; Tue, 26 Feb 2002 00:19:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16140 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293522AbSBZFSv>; Tue, 26 Feb 2002 00:18:51 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux 2.4.18
Date: 25 Feb 2002 21:18:13 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a5f5ql$2jl$1@cesium.transmeta.com>
In-Reply-To: <20020225233230.GB11786@merlin.emma.line.org> <Pine.LNX.3.96.1020226000221.20055B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.3.96.1020226000221.20055B-100000@gatekeeper.tmr.com>
By author:    Bill Davidsen <davidsen@tmr.com>
In newsgroup: linux.dev.kernel
>
> On Tue, 26 Feb 2002, Matthias Andree wrote:
> 
> > I'd think that running a script to "upgrade" 2.4.N-rcM to 2.4.N by just
> > unpacking that latest rc tarball, editing the Makefile and tarring
> > things up again, should be safe enough, and if it doesn't allow for
> > operator interference, especially so. 
> 
> Seems to me:
> - clean EXTRAVERSION
> - make new diff
> - make tar (one please)
> - make tar.gz from tar
> - compress tar to tar.bz2
> 

For what it's worth, I have written such a script and made it
available on master.kernel.org.  The kernel maintainers have been sent
directions; it's of course up to them if they want to use it.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
