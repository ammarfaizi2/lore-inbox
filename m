Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbSI0M2P>; Fri, 27 Sep 2002 08:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261694AbSI0M2P>; Fri, 27 Sep 2002 08:28:15 -0400
Received: from 62-190-201-242.pdu.pipex.net ([62.190.201.242]:2564 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261693AbSI0M2P>; Fri, 27 Sep 2002 08:28:15 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209271240.g8RCeiBH000229@darkstar.example.net>
Subject: Re: Distributing drivers independent of the kernel source tree
To: arjanv@redhat.com (Arjan van de Ven)
Date: Fri, 27 Sep 2002 13:40:43 +0100 (BST)
Cc: Daniel.Heater@gefanuc.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com
In-Reply-To: <1033074519.2698.5.camel@localhost.localdomain> from "Arjan van de Ven" at Sep 26, 2002 11:08:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2. Assuming the kernel source is in /usr/src/linux is not always valid.
> >=20
> > 3. I currently use /usr/src/linux-`uname -r` to locate the kernel source
> > which is just as broken as method #2.
> 
> you have to use
> 
> /lib/modules/`uname -r`/build
> (yes it's a symlink usually, but that doesn't matter)
> 
> 
> that's what Linus decreed and that's what all distributions honor, and
> that's that make install does for manual builds.

What about instances where there is no modular support in the kernel?  All of my main machines have loadable module support disabled...  That seems to be a very rare configuration these days, but I prefer it.

John,
