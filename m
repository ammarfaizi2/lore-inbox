Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265252AbUE2RVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265252AbUE2RVq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 13:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265260AbUE2RVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 13:21:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55232 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265252AbUE2RVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 13:21:43 -0400
Date: Sat, 29 May 2004 19:21:36 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Artemio <theman@artemio.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: error compiling linux-2.6.6
Message-ID: <20040529172136.GS16099@fs.tum.de>
References: <200405291424.43982.theman@artemio.net> <200405291620.49602.theman@artemio.net> <200405291646.55856.ornati@fastwebnet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405291646.55856.ornati@fastwebnet.it>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 04:46:55PM +0200, Paolo Ornati wrote:
> On Saturday 29 May 2004 15:21, you wrote:
> > I am continuing my tries...
> >
> > GCC 2.96, linux-2.6.6.
> > ...
> >
> > Am I doing something wrong? :-(
> 
> YES, you are using a very BUGGY gcc version!

It's an unofficial gcc version, but it's not necessary more buggy than 
other versions of gcc.

And Documentation/Changes in Linux 2.6.6 also tells that your statement
is wrong:

<--  snip  -->

...
The Red Hat gcc 2.96 compiler subtree can also be used to build this tree.
You should ensure you use gcc-2.96-74 or later. gcc-2.96-54 will not build
the kernel correctly.
...

<--  snip  -->

> Try 2.95.x (x >= 3) or go to 3.x.x.
>...

His problem is as far as I can see in no way related to the gcc version 
he's using.

> Bye

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

