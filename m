Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261424AbSIWSsj>; Mon, 23 Sep 2002 14:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSIWSsD>; Mon, 23 Sep 2002 14:48:03 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261410AbSIWSmh>;
	Mon, 23 Sep 2002 14:42:37 -0400
Date: Mon, 23 Sep 2002 10:10:09 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Remco Post <r.post@sara.nl>
cc: Tom Rini <trini@kernel.crashing.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.38 on ppc/prep
In-Reply-To: <4FDC416F-CF02-11D6-A08A-000393911DE2@sara.nl>
Message-ID: <Pine.LNX.4.44.0209231008580.13892-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2002, Remco Post wrote:

> > What typo exactly?  The only 'lib' in the Makefile
> > (arch/ppc/boot/prep/Makefile) is:
> > LIBS = ../lib/zlib.a
> >
> 
> That one exactly... I don't recall calling it a typo, though ;-) I guess 
> that is more a relic from when the only lib routines were libz ones and 
> we called the lib to be linked libz.a....

That's my bad, I renamed the L_TARGET but obviously missed some references
to it. I'll include a fix in my next update.

--Kai


