Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267552AbTA1TIh>; Tue, 28 Jan 2003 14:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265099AbTA1TIh>; Tue, 28 Jan 2003 14:08:37 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:5081 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267552AbTA1TIg>; Tue, 28 Jan 2003 14:08:36 -0500
Date: Tue, 28 Jan 2003 13:17:43 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Mark Fasheh <mark.fasheh@oracle.com>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: no version magic, tainting kernel.
In-Reply-To: <20030128191018.GD17737@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.44.0301281316060.1777-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2003, Mark Fasheh wrote:

> On Tue, Jan 28, 2003 at 12:58:40PM +1100, Rusty Russell wrote:
> > And then you'll die horribly next time Kai or I change the way modules
> > are built.
> > 
> > Really, using the Makefiles is always the most future-proof way!
> I've actually converted my stuff to use the Makefiles, which does simplify
> things, but the problem I had was mainly with the whole vermagic.c stuff and
> needing a full source tree + compiled objects (or having the tree writeable
> by users who want to compile modules) around just to build my module.
> Anyway, Joel Becker, Christian Zander and others have eloquently voiced my
> complaints previously in this thread, so I won't go over them again :)
> 
> As far as using the kernel build system, so far so good - it's nice, and
> builds things correctly though I'm having some trouble getting it to
> install my module correctly, which may just indicate that I need to re-read
> the docs.

The docs are kinda out-of-date, expect an update (thanks to Sam Ravnborg) 
soon. However, there aren't provisions for installing third party modules 
yet, so that's on my todo list together with the points above.

--Kai

