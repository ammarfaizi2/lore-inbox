Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289484AbSAOKqN>; Tue, 15 Jan 2002 05:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289491AbSAOKqD>; Tue, 15 Jan 2002 05:46:03 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:31144 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289484AbSAOKpr>; Tue, 15 Jan 2002 05:45:47 -0500
Message-Id: <200201151045.g0FAjduU002847@tigger.cs.uni-dortmund.de>
To: David Lang <david.lang@digitalinsight.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away? 
In-Reply-To: Message from David Lang <david.lang@digitalinsight.com> 
   of "Mon, 14 Jan 2002 10:57:19 PST." <Pine.LNX.4.40.0201141055410.22904-100000@dlang.diginsite.com> 
Date: Tue, 15 Jan 2002 11:45:39 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 14 Jan 2002, Alan Cox wrote:

> > > 1. security, if you don't need any modules you can disable modules
> > > entirly and then it's impossible to add a module without patching
> > > the kernel first (the module load system calls aren't there)

> > Urban legend.

> If this is the case then why do I get systemcall undefined error messages
> when I make a mistake and attempt to load a module on a kernel without
> modules enabled?

AFAIU the security improvement of no-modules are way overrated.

[...]

> > > 3. simplicity in building kernels for other machines. with a monolithic
> > > kernel you have one file to move (and a bootloader to run) with modules
> > > you have to move quite a few more files.

> > tar or nfs mount; make modules_install.

> not on my firewalls thank you.

You keep compilers and stuff on your firewalls then?!

I get them over via ssh or by floppy/CD. Same idea.
-- 
Horst von Brand			     http://counter.li.org # 22616
