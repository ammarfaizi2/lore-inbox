Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317434AbSGVO2c>; Mon, 22 Jul 2002 10:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317450AbSGVO2b>; Mon, 22 Jul 2002 10:28:31 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:12427 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317434AbSGVO2a>; Mon, 22 Jul 2002 10:28:30 -0400
Date: Mon, 22 Jul 2002 09:31:33 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Tomas Szepe <szepe@pinerecords.com>
cc: Miles Lane <miles@megapathdsl.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.27 -- memory.c:50:22: asm/rmap.h: No such file or directory
In-Reply-To: <20020721053902.GA13191@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0207220929170.28150-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jul 2002, Tomas Szepe wrote:

> > Hmm.  Sorry for the noise.  I think made a backup
> > of 2.5 without running "make mrproper" first.
> 
> Your report is actually helpful, not so much to Rik, though. According
> to Kai Germaschewski (Subject: Re: piggy broken in 2.5.24 build, Date:
> Sat, 22 Jun 2002), "For the current kbuild, you should never need to do
> make mrproper, it  should always recognize changes and rebuild what's
> necessary."
> 
> Well, what's the problem, Kai?

Since I don't have my crystal ball with me, it's really hard to tell. On 
a wild guess, when he backed up his kernel he converted his include/asm 
symlink into a real directory, which then makes "rm include/asm" fail for 
obvious reasons.

--Kai


