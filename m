Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135580AbRDXMx1>; Tue, 24 Apr 2001 08:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135579AbRDXMxK>; Tue, 24 Apr 2001 08:53:10 -0400
Received: from [24.70.141.118] ([24.70.141.118]:2546 "EHLO asdf.capslock.lan")
	by vger.kernel.org with ESMTP id <S135578AbRDXMxB>;
	Tue, 24 Apr 2001 08:53:01 -0400
Date: Tue, 24 Apr 2001 08:52:51 -0400 (EDT)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: <imel96@trustix.co.id>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [OFFTOPIC] Re: [PATCH] Single user linux
In-Reply-To: <Pine.LNX.4.33.0104241830020.11899-100000@tessy.trustix.co.id>
Message-ID: <Pine.LNX.4.33.0104240846000.21785-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2001 imel96@trustix.co.id wrote:

>a friend of my asked me on how to make linux easier to use
>for personal/casual win user.
>
>i found out that one of the big problem with linux and most
>other operating system is the multi-user thing.
>
>i think, no personal computer user should know about what's
>an operating system idea of a user. they just want to use
>the computer, that's it.
>
>by a personal computer i mean home pc, notebook, tablet,
>pda, and communicator. only one user will use those devices,
>or maybe his/her friend/family. do you think that user want
>to know about user account?
>
>from that, i also found out that it is very awkward to type
>username and password every time i use my computer.
>so here's a patch. i also have removed the user_struct from
>my kernel, but i don't think you'd like #ifdef's.
>may be it'll be good for midori too.

trustix.co.id?  hehehe.

If you don't want to login with user/password, then change your
password to "".  Don't want to even do that?  Then just change
/etc/inittab to invoke "login -f username" instead of mingetty or
whatever.  No need at all to hack the kernel up.

Dunno why you sent the patch here or to Linus though..  The
chance of it even being looked at are about 1/2^infinity  ;o)

I've got a hacked up version of mingetty that allows you to
configure autologins on tty's if you like.  You're welcome to my
packages if you like just email me privately. It is useful if you
are in an environment where physical security is not a concern at
all, but network security is still a concern.  I use it so I can
boot up, login once, and it fires up tty's on all consoles for
me.  It can also bypass any login if you like.


----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

