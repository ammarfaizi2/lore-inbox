Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315476AbSEZAV6>; Sat, 25 May 2002 20:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315481AbSEZAV5>; Sat, 25 May 2002 20:21:57 -0400
Received: from ns.suse.de ([213.95.15.193]:5136 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315476AbSEZAVz>;
	Sat, 25 May 2002 20:21:55 -0400
Date: Sun, 26 May 2002 02:21:55 +0200
From: Dave Jones <davej@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
        Luigi Genoni <kernel@Expansa.sns.it>, Luca Barbieri <ldb@ldb.ods.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.4] [2.5] [i386] Add support for GCC 3.1 -march=pentium{-mmx,3,4}
Message-ID: <20020526022155.F16102@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"J.A. Magallon" <jamagallon@able.es>,
	Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
	Luigi Genoni <kernel@Expansa.sns.it>,
	Luca Barbieri <ldb@ldb.ods.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205260044270.10923-100000@sharra.ivimey.org> <20020526010849.GA10643@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 03:08:49AM +0200, J.A. Magallon wrote:
 > I think that the menu should contain separate config options for each
 > processor type, so it is easily modifiable for specific optimizations
 > offered by new compilers (for example, gcc-3.1 splitting i686 in
 > pentium-pro, p2, p3 and p4), or some braindead hacker can optimize
 > code snippets for some kind of processor.

Something like..

http://www.codemonkey.org.uk/patches/old/cpu-choice-2.diff
perhaps ? My original motivation wasn't so that we could fine grain the
compiler flags, but to cut down on the "my cpu wasn't in the list and
I didn't know which one to pick" bug reports.

I got sidetracked with something else though, which meant I never saw
this patch through to completion.. if theres any interest I'll pick it
up again.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
