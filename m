Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312525AbSDOAnw>; Sun, 14 Apr 2002 20:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSDOAnv>; Sun, 14 Apr 2002 20:43:51 -0400
Received: from [212.57.170.89] ([212.57.170.89]:27913 "EHLO zzz.zzz")
	by vger.kernel.org with ESMTP id <S312525AbSDOAnu>;
	Sun, 14 Apr 2002 20:43:50 -0400
Date: Mon, 15 Apr 2002 06:38:26 +0600
From: Denis Zaitsev <zzz@cd-club.ru>
To: Dave Jones <davej@suse.de>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: FIXED_486_STRING ?
Message-ID: <20020415063825.A2691@natasha.zzz.zzz>
In-Reply-To: <20020413224743.A13355@natasha.zzz.zzz> <32667.1018744038@ocs3.intra.ocs.com.au> <20020414024406.A16692@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2002 at 02:44:06AM +0200, Dave Jones wrote:
> On Sun, Apr 14, 2002 at 10:27:18AM +1000, Keith Owens wrote:
> 
>  > Dead code, it has been dead since at least 2.0.21.  Unless somebody
>  > wants to fix the string-486 code, delete FIXED_486_STRING,
>  > CONFIG_X86_USE_STRING_486 and include/asm-i386/string-486.h.
> 
> I proposed doing this a few months back, then someone stepped forward
> who had worked on these routines recently and fixed up whatever problems
> they originally exhibited.  Deleting the dead code from 2.2 / 2.4 probably
> makes sense, but it'd be nice to have the 2.5 ones fixed up.
> 
>     Dave.
> 
Yes, the special code for Pentium is important for it, as that code is
faster and shorter.  The last signature in string-486.h is of
2000/05/09, so, if this is true, the problems have not been fixed.
So, what is the real situation?  I would like to fix the code, and it
seems that I'm not alone :)
