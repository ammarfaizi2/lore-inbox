Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266986AbTAZUyl>; Sun, 26 Jan 2003 15:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266987AbTAZUyl>; Sun, 26 Jan 2003 15:54:41 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:22726 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S266986AbTAZUyk>; Sun, 26 Jan 2003 15:54:40 -0500
Date: Sun, 26 Jan 2003 22:57:14 +0100
From: Christian Zander <zander@minion.de>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Christian Zander <zander@minion.de>, Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030126215714.GA394@kugai>
Reply-To: Christian Zander <zander@minion.de>
References: <20030126132923.GB396@kugai> <Pine.LNX.4.44.0301261144430.15538-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301261144430.15538-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2003 at 11:51:22AM -0600, Kai Germaschewski wrote:
> 
> Well, what I'm trying to say is that external build system will
> always break one way or other. Since they're external, they're
> naturally out of reach for me to influence, so there's really
> nothing I can do it but telling people to using the internal system
> instead.
> 

External build systems have been working just fine even after kbuild
was adopted as the build system of choice for the Linux kernel, there
should be more convincing reasons for deliberately breaking them now.

> Again, when you're using your own external build system, it's up to
> you to mess it up in all possible ways, the above being one of them.
> 
> When you're using the kernel build, the above cannot happen, since
> the kernel build system knows about this dependency and builds a new
> init/vermagic.o with the correct information before it gets linked
> into the external module.
> 

Is that so? Does kbuild determine that vermagic.o needs rebuilding if
the compiler version changed?

-- 
christian zander
zander@minion.de
