Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318005AbSGLUpe>; Fri, 12 Jul 2002 16:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318009AbSGLUpd>; Fri, 12 Jul 2002 16:45:33 -0400
Received: from ns.suse.de ([213.95.15.193]:15374 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318005AbSGLUpc>;
	Fri, 12 Jul 2002 16:45:32 -0400
Date: Fri, 12 Jul 2002 22:48:20 +0200
From: Dave Jones <davej@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thunder from the hill <thunder@ngforever.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
Message-ID: <20020712224820.D18503@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Roman Zippel <zippel@linux-m68k.org>,
	Thunder from the hill <thunder@ngforever.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020712203737.C18503@suse.de> <Pine.LNX.4.44.0207122230360.28515-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207122230360.28515-100000@serv>; from zippel@linux-m68k.org on Fri, Jul 12, 2002 at 10:34:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 10:34:29PM +0200, Roman Zippel wrote:

 > > OFS afaik. Has this always been the case ? I'm sure I ran fsx without
 > > disabling mmap before on this image, and it used to pass.
 > ofs never supported mmap.

Interesting. My old testing must have been with an ffs image I guess.
 
 > > Second bad news, with the -W -R options, it goes splat in an
 > > even more dramatic way.
 > Which kernel version? It looks like a bug which already has been fixed
 > quite some time ago.

2.5.25-dj1. I expect the same problem to exist in mainline if its
AFFS specific, as I currently have no patches in that area.

Unfortunatly I've not time right now to test mainline, as I've
more important things to do before I catch a flight.  If it's
still happening when I get back in a week or so, I'll try again.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
