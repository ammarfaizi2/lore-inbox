Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267767AbTBGJay>; Fri, 7 Feb 2003 04:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267769AbTBGJay>; Fri, 7 Feb 2003 04:30:54 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:40710 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267767AbTBGJav>; Fri, 7 Feb 2003 04:30:51 -0500
Date: Fri, 7 Feb 2003 10:39:44 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Greg KH <greg@kroah.com>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       <linux-kernel@vger.kernel.org>, <jgarzik@pobox.com>
Subject: Re: [PATCH] Restore module support.
In-Reply-To: <20030207040606.GA30337@kroah.com>
Message-ID: <Pine.LNX.4.44.0302071016060.1336-100000@serv>
References: <20030204233310.AD6AF2C04E@lists.samba.org>
 <Pine.LNX.4.44.0302062358140.32518-100000@serv> <20030206232515.GA29093@kroah.com>
 <Pine.LNX.4.44.0302070037230.32518-100000@serv> <20030207040606.GA30337@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 6 Feb 2003, Greg KH wrote:

> > There should be no real difference as I'd like to integrate Kai's patch too.
> 
> Ok, I'm confused, you're advocating putting back the old modutils
> interface, but somehow not using the old modutils code?  I don't
> understand.

No, I'm advocating to break as little as possible. I'm certainly willing 
to port any interesting feature from Rusty's patches. If one feature 
requires changes to modutils, that's fine.

> Neither one of those proposals, no any others, were backed with working
> examples.  Rusty had the only working example of getting rid of the
> userspace knowledge of the kernel data structures that I know of so far.

1. In the past I posted enough example code, which was pretty much 
ignored, why should I think it would be any different this time?
2. Is hotplug that broken, that it wouldn't survive 2.6, so it required a 
complete new implementation? If that should be case I herewith volunteer 
to add module alias support to modutils.

bye, Roman

