Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSFET72>; Wed, 5 Jun 2002 15:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316167AbSFET71>; Wed, 5 Jun 2002 15:59:27 -0400
Received: from ns.suse.de ([213.95.15.193]:29711 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316161AbSFET71>;
	Wed, 5 Jun 2002 15:59:27 -0400
Date: Wed, 5 Jun 2002 21:59:27 +0200
From: Dave Jones <davej@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Russell King <rmk@arm.linux.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow mpage.c to build
Message-ID: <20020605215927.I16262@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Andrew Morton <akpm@zip.com.au>, Russell King <rmk@arm.linux.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020605160547.C10293@flint.arm.linux.org.uk> <3CFE6B31.39EC2719@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 12:49:05PM -0700, Andrew Morton wrote:

 > /usr/src/25/include/linux/bio.h
 >  /usr/src/25/include/asm/io.h
 >   /usr/src/25/include/linux/vmalloc.h
 >    /usr/src/25/include/linux/mm.h
                                ^^^^^
This bugger should be high on the list of include files that need
feeding through the include-chopper-upper.

 >     /usr/src/25/include/linux/swap.h
 >      /usr/src/25/include/linux/kdev_t.h
 > Lovely, isn't it?

Wouldn't be so bad if it were an isolated case..
Hopefully by the time we get to 2.6, a lot of this
'include by implication' nonsense can be cleaned up some more.

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
