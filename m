Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267765AbTBGJhQ>; Fri, 7 Feb 2003 04:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267769AbTBGJhQ>; Fri, 7 Feb 2003 04:37:16 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:57356 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267765AbTBGJhP>; Fri, 7 Feb 2003 04:37:15 -0500
Date: Fri, 7 Feb 2003 10:46:15 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Restore module support.
In-Reply-To: <Pine.LNX.4.44.0302070006110.31954-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0302071042410.1336-100000@serv>
References: <Pine.LNX.4.44.0302070006110.31954-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 7 Feb 2003, Kai Germaschewski wrote:

> So you have the choice of either sticking to the solution which was 
> previously used (only that it's now done in the kernel, not in modutils), 
> or doing something new and more efficient.

Where is the problem to do the "new and more efficient" in modutils?

> Now, what's the reason you're not happy with that? You've got more
> flexibility than before, and you can even switch between different ways
> without having to teach an external package about it, so you avoid the
> compatibility issues when kernel and modutils are not in sync.

Where is the problem with updating user space tools? We should certainly 
reduce dependencies, but moving everything into the kernel source can't be 
the answer either.

bye, Roman

