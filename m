Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbTKTUY0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 15:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbTKTUY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 15:24:26 -0500
Received: from edu.joroinen.fi ([194.89.68.130]:39842 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id S261882AbTKTUYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 15:24:24 -0500
Date: Thu, 20 Nov 2003 22:24:22 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: Diego Calleja =?iso-8859-1?Q?Garc=EDa?= <aradorlinux@yahoo.es>
Cc: Nick Piggin <piggin@cyberone.com.au>, wli@holomorphy.com,
       jgarzik@pobox.com, jt@hpl.hp.com, linux-kernel@vger.kernel.org,
       pof@users.sourceforge.net
Subject: Re: Announce: ndiswrapper
Message-ID: <20031120202422.GA3397@edu.joroinen.fi>
References: <20031120031137.GA8465@bougret.hpl.hp.com> <3FBC3483.4060706@pobox.com> <20031120040034.GF19856@holomorphy.com> <3FBC402E.6070109@cyberone.com.au> <20031120043848.GG19856@holomorphy.com> <3FBC4A42.8010806@cyberone.com.au> <20031120134121.02e11aff.aradorlinux@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031120134121.02e11aff.aradorlinux@yahoo.es>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 01:41:21PM +0100, Diego Calleja García wrote:
> El Thu, 20 Nov 2003 15:59:46 +1100 Nick Piggin <piggin@cyberone.com.au> escribió:
> 
> > I must say that I've been using the same nvidia drivers on my desktop
> > system for maybe a year, and never had a crash including going through
> > countless versions of 2.5/6. True you need to recompile the intermediate
> 
> You're lucky.
> Nvidia drivers are broken, and it's not just linux. Their windows drivers
> are know to be buggy, too. And this is happening in windows (which has a
> "windows driver model" abi which doesn't change even between W9x and nt)
> 
> Also, they don't support non-x86 architectures in linux (they have drivers
> for mac os X though)
> If there're a lot of binary drivers for linux, we'll have the same hell
> microsoft has (w2k and XP are rock solid, until you start using crappy
> drivers, then everybody complains about blue screens). A stable and defined
> abi (like their driver model) doesn't work for them, it won't work for us. 
> 
> I don't mind running propietary code...but not in the kernel.
> 
> (BTW, are there modern graphics cards with 100% opensource drivers?)
> 

None of the new chips (r300, any nvidia, matrox, etc) has opensource 3D
drivers. 

If you want good 3D support (OpenGL) you need to use binary drivers :(

DRI (opensource) opengl-drivers have support for only ati r200 and older
cards.. so nothing new. And DRI drivers don't support the advanced features
of these cards.. so no shaders etc :(

OpenGL support in DRI drivers feels also more buggy than Nvidia/ATI binary
drivers :(

So the situation is not good..

-- Pasi Kärkkäinen
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.
