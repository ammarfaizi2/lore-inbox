Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317286AbSILUtO>; Thu, 12 Sep 2002 16:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSILUtN>; Thu, 12 Sep 2002 16:49:13 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:22199 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317286AbSILUtM>; Thu, 12 Sep 2002 16:49:12 -0400
Date: Thu, 12 Sep 2002 15:53:45 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Generated files destruction
In-Reply-To: <20020912072006.EBADF2C0C7@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0209121551010.31494-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2002, Rusty Russell wrote:

> 	I would like to start migrating all build-generated files to
> names matching "generated*" or ".generated*", esp. those which look
> like source files.  This is mainly for readability and for simplicity
> when diffing built kernel trees.  I'll be encouraging various
> maintainers who generate (.c, .h and .s) files which are not meant to
> be shipped with the kernel source to migrate, in my copious free
> time...

I think the proper solution here is actually separate obj/src dirs, 
instead of special names. It's actually quite easy to get that implemented 
in the current kbuild, I just didn't find the time for proper testing yet. 
I'll have a patch ready for testing soon, though.

-Kai


