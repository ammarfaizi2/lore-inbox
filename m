Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbSI3QTI>; Mon, 30 Sep 2002 12:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262412AbSI3QS4>; Mon, 30 Sep 2002 12:18:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10503 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262380AbSI3QSk>; Mon, 30 Sep 2002 12:18:40 -0400
Date: Mon, 30 Sep 2002 09:23:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Generated files destruction
In-Reply-To: <Pine.LNX.4.44.0209121551010.31494-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0209300919220.2610-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Sep 2002, Kai Germaschewski wrote:
> 
> I think the proper solution here is actually separate obj/src dirs, 
> instead of special names. It's actually quite easy to get that implemented 
> in the current kbuild, I just didn't find the time for proper testing yet. 
> I'll have a patch ready for testing soon, though.

Please keep in mind that some people (at least me) don't like separate
build trees - I do all the "real work" in the source directory, and if I
need to go somewhere else to build, that's just a pain (and it's another
pain if, once I'm building, I have to use a different path than the one
that I'm used to in the source directory to fix something).

So I want to keep the mixed tree around (which is not to say that people 
who like the separate-object-tree thing shouldn't be _able_ to use it).

		Linus

