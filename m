Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261304AbSJHOa1>; Tue, 8 Oct 2002 10:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSJHOa1>; Tue, 8 Oct 2002 10:30:27 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:58502 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261304AbSJHOaY>; Tue, 8 Oct 2002 10:30:24 -0400
Date: Tue, 8 Oct 2002 09:35:56 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: vpath broken in 2.5.41 
In-Reply-To: <29031.1034071743@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0210080932210.32256-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, Keith Owens wrote:

> >On Tue, 8 Oct 2002, John Levon wrote:
> >> I see vpath seems to have become broken in 2.5.41 build.
> >> How now can I build the oprofile.o target from two directories ?
>
> This is one of the problems that kbuild 2.5 was designed to handle, to
> cope with modules built from code in multiple directories.  I support
> what the developer wants to do, not restrict the developer to what the
> kernel build can handle.

So would you mind telling me what arch/i386/drivers/Makefile.in would 
look like for a module which is built from sources in arch/i386/drivers 
and drivers/oprofile ?

(And no, I won't get into another general kbuild-2.5 flamewar, just in 
case this should start one again).

--Kai




