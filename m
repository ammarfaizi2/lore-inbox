Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262480AbTCIIrq>; Sun, 9 Mar 2003 03:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262482AbTCIIrq>; Sun, 9 Mar 2003 03:47:46 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:19984 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S262480AbTCIIrp>;
	Sun, 9 Mar 2003 03:47:45 -0500
Date: Sun, 9 Mar 2003 09:57:43 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       root@chaos.analogic.com
Subject: Re: Make ipconfig.c work as a loadable module.
Message-ID: <20030309085743.GA6138@alpha.home.local>
References: <Pine.LNX.3.95.1030307094333.15013A-100000@chaos> <200303090121.h291LDbx003771@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303090121.h291LDbx003771@eeyore.valparaiso.cl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 10:21:13PM -0300, Horst von Brand wrote:
> The "floppy booting" discussed here is doing:
> 
>    dd if=bzImage of=/dev/fd0
> 
> and booting that floppy directly. I really don't remember when I did that
> last time, it must have been at least 5 years ago.

I do use it frequently. I frequently boot systems using PXE, but sometimes,
either the bios is buggy, or I don't find how to set it up correctly, so the
better, and most reliable solution is to insert a floppy containing the kernel
which would have been loaded from the PXE server.

In fact, NONE of my systems need nor use an initrd. I find it really useful
to be able to boot from one single file. Having to set up an initrd is really
a pain compared to other trivial solutions. I'd really like Linux not to become
like microsoft products : it's not because one developper doesn't have the need
for something that he must prevent all his users/customers from using it.

I think that there are several people here who think they need ipconfig, and
that should be enough to understand that it's a useful feature, even if you
don't need it yourself.

Regards,
Willy

