Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317430AbSFROg1>; Tue, 18 Jun 2002 10:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317431AbSFROg0>; Tue, 18 Jun 2002 10:36:26 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:36309 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317430AbSFROgZ>; Tue, 18 Jun 2002 10:36:25 -0400
Date: Tue, 18 Jun 2002 09:36:17 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "Hans E. Kristiansen" <hans@tropic.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.22 problems with compile.h
In-Reply-To: <009401c216b4$22458160$252ca8c0@sdfg>
Message-ID: <Pine.LNX.4.44.0206180931410.5695-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Hans E. Kristiansen wrote:

> >From a clean install, I can compile, but I get an error with compile.h (Do
> not know how to make compile.h). If I compile again, I get a working kernel
> (bzImage), "depmod -ae -F xx " works like a charm. But, when I reboot with
> the new kernel, I can not load any modules. None, they all have symbol
> problems.

Seems that I screwed up that version a bit ;( 

For now, don't use something like "make dep clean bzImage", but rather
"make clean; make dep bzImage" - it'll work again in the next release,
though.

Modversions also have bugs, though I can't see how they lead to the effect 
you describe. Anyway, try changing CONFIG_MODVERSIONS to off for now,
again, it should work again in the next release.

Let me know of further problems ;)

--Kai


