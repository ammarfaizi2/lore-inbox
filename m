Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136608AbREGSsL>; Mon, 7 May 2001 14:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136604AbREGSsC>; Mon, 7 May 2001 14:48:02 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:20492 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136609AbREGSrv>; Mon, 7 May 2001 14:47:51 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Wow! Is memory ever cheap!
Date: 7 May 2001 11:47:34 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9d6qk6$i86$1@cesium.transmeta.com>
In-Reply-To: <20010505095802.X12431@work.bitmover.com> <20010506142043.B31269@metastasis.f00f.org> <20010505194536.D14127@work.bitmover.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010505194536.D14127@work.bitmover.com>
By author:    Larry McVoy <lm@bitmover.com>
In newsgroup: linux.dev.kernel
>
> On Sun, May 06, 2001 at 02:20:43PM +1200, Chris Wedgwood wrote:
> > 1.5GB without ECC? Seems like a disater waiting to happen? Is ECC
> > memory much more expensive?
> 
> Almost twice as expensive for 512MB dimms.
> 
> I used to be a die hard ECC fan but that changed since what we do here is
> BitKeeper and BitKeeper checksums everything.  It tells us right away when
> we have problems (to date it has found bad memory dimms, NFS corruption,
> and a SPARC/Linux cache aliasing bug).  So I've given up in ECC, we don't
> need it.
> 
> On the other hand, if your apps don't have built in integrity checks then
> ECC is pretty much a requirement.
> 

Isn't this pretty much saying "if you're willing to dedicate your
system to running nothing but Bitkeeper, you can run it really fast?"

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
