Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTETPXa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 11:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbTETPXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 11:23:30 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:11532 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S263777AbTETPXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 11:23:30 -0400
Date: Tue, 20 May 2003 17:33:41 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Brian Gerst <bgerst@didntduck.org>, Sam Ravnborg <sam@ravnborg.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Update fs Makefiles
In-Reply-To: <Pine.LNX.4.44.0305200940130.24017-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0305201726200.12110-100000@serv>
References: <Pine.LNX.4.44.0305200940130.24017-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 20 May 2003, Kai Germaschewski wrote:

> > >>-adfs-objs := dir.o dir_f.o dir_fplus.o file.o inode.o map.o super.o
> > >>+adfs-y := dir.o dir_f.o dir_fplus.o file.o inode.o map.o super.o
> > > 
> > > 
> > 
> > Why have two methods of doing the same thing?  foo-y is clearly the 
> > preferred method because it is easy to work with conditionals.
> 
> I tend to agree, though I don't feel strongly about it. Having two 
> different methods of expressing the same thing will always be confusing. 

Has the new syntax any advantage, e.g. does it make sense to have adfs-m? 
Otherwise the -obj syntax looks IMO more readable and it directly says 
that this is a composite object.

bye, Roman

