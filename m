Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSIHXNv>; Sun, 8 Sep 2002 19:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSIHXNv>; Sun, 8 Sep 2002 19:13:51 -0400
Received: from ns.suse.de ([213.95.15.193]:39685 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315503AbSIHXNv>;
	Sun, 8 Sep 2002 19:13:51 -0400
Date: Mon, 9 Sep 2002 01:18:33 +0200
From: Dave Jones <davej@suse.de>
To: Daniel Mehrmann <daniel.mehrmann@gmx.de>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4/2.5] Athlon CFLAGS
Message-ID: <20020909011833.B14358@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Daniel Mehrmann <daniel.mehrmann@gmx.de>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <200209082128.11316.daniel.mehrmann@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200209082128.11316.daniel.mehrmann@gmx.de>; from daniel.mehrmann@gmx.de on Sun, Sep 08, 2002 at 09:28:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2002 at 09:28:11PM +0200, Daniel Mehrmann wrote:
 > Hi Alan,
 > 
 > i add for the AMD Athlon family some optimize compilerflags. 
 > Gcc 3.1 and 3.2 support more specific Athlon instructions as 3.0 or 2.95x. 
 > This patch for 2.4.19, 2.4.20-pre5 and 2.5.33 set a new "-march" flag:
 > 
 > Athlon TB/Duron 		+= -march=athlon-tbird
 > Athlon XP/Athlon4/Duron	+= -march=athlon-xp
 > Athlon MP				+= -march=athlon-mp

I thought these were all just gcc aliases for the same options ?
It's been a while since I looked at the gcc option parser, so I've
forgotten exactly what happens, but at least you missed the
bogus athlon-4 option.

Are the gains between all these options really worth the added
complexity ?

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
