Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261695AbSI0M4A>; Fri, 27 Sep 2002 08:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261696AbSI0M4A>; Fri, 27 Sep 2002 08:56:00 -0400
Received: from 62-190-217-91.pdu.pipex.net ([62.190.217.91]:13316 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261695AbSI0Mz7>; Fri, 27 Sep 2002 08:55:59 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209271308.g8RD8JPE000494@darkstar.example.net>
Subject: Re: Distributing drivers independent of the kernel source tree
To: schwab@suse.de (Andreas Schwab)
Date: Fri, 27 Sep 2002 14:08:19 +0100 (BST)
Cc: arjanv@redhat.com, Daniel.Heater@gefanuc.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com
In-Reply-To: <jed6qzy4xi.fsf@sykes.suse.de> from "Andreas Schwab" at Sep 27, 2002 02:48:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> jbradford@dial.pipex.com writes:
> 
> |> > > 2. Assuming the kernel source is in /usr/src/linux is not always valid.
> |> > >=20
> |> > > 3. I currently use /usr/src/linux-`uname -r` to locate the kernel source
> |> > > which is just as broken as method #2.
> |> > 
> |> > you have to use
> |> > 
> |> > /lib/modules/`uname -r`/build
> |> > (yes it's a symlink usually, but that doesn't matter)
> |> > 
> |> > 
> |> > that's what Linus decreed and that's what all distributions honor, and
> |> > that's that make install does for manual builds.
> |> 
> |> What about instances where there is no modular support in the kernel?
> 
> If your kernel has no module support then you cannot compile kernel
> modules.

Sorry, my first post was a brain fart, I thought the original poster was talking about the correct way to identify the verison of source code that you're 'looking at'.  Appologies for the wasted bandwidth.

John.
