Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265681AbSLJT6M>; Tue, 10 Dec 2002 14:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265713AbSLJT6M>; Tue, 10 Dec 2002 14:58:12 -0500
Received: from [195.39.17.254] ([195.39.17.254]:516 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265681AbSLJT6K>;
	Tue, 10 Dec 2002 14:58:10 -0500
Date: Mon, 9 Dec 2002 22:49:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: #! incompatible -- binfmt_script.c broken?
Message-ID: <20021209214953.GA1624@elf.ucw.cz>
References: <9633612287A@vcnet.vc.cvut.cz> <20021206090234.GA1940@zaurus> <3DF4DEC0.3030800@zytor.com> <20021209182605.GA22747@atrey.karlin.mff.cuni.cz> <at2qin$fgn$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <at2qin$fgn$1@cesium.transmeta.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Why can't we simply have /bin/bash_that_splits_args_itself
> > > 
> > > We could, but it would in practice mean doing an extra exec() for each
> > > executable.  This seems undesirable.
> > 
> > Only for executables that need argument spliting... For such scripts I
> > guess we can get handle the overhead.
> > 
> 
> We probably can, but a better question is really: what are the
> semantics that users expect?  Given that Unices are by and large
> inconsistent, we should pick the behaviour that makes sense to the
> most people.  I suspect that most people would expect whitespace
> partition.

Most people would also expect " and ' to work, and $FOO to work
:-(. So I believe keeping it simple is right.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
