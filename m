Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSGUBaB>; Sat, 20 Jul 2002 21:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317331AbSGUBaB>; Sat, 20 Jul 2002 21:30:01 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:20495 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S315748AbSGUBaA>; Sat, 20 Jul 2002 21:30:00 -0400
Subject: Re: 2.5.27 -- memory.c:50:22: asm/rmap.h: No such file or directory
From: Miles Lane <miles@megapathdsl.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L.0207202153190.12241-100000@imladris.surriel.com>
References: <Pine.LNX.4.44L.0207202153190.12241-100000@imladris.surriel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1027215133.1863.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 20 Jul 2002 21:32:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-20 at 20:53, Rik van Riel wrote:
> On 20 Jul 2002, Miles Lane wrote:
> > On Sat, 2002-07-20 at 20:47, Rik van Riel wrote:
> > > On 20 Jul 2002, Miles Lane wrote:
> > >
> > > > Hmm.  This problem looks pretty straightforward.
> > >
> > > Indeed.  Have you tried 'make oldconfig' to set the
> > > symlink in include/ ?
> >
> > Yeah.  I mention that in my first message.  ;-)
> 
> So, does the symlink exist ?
> 
> I'm asking that because gcc has no problem finding <asm/rmap.h>
> here or at anybody else's place ;)

Hmm.  I don't have an asm directory, in spite of running oldconfig.
I suspect this problem is a result of the previous problem
I reported with "make mrproper" having an error?

I will try creating a completely new tree and then use that 
.config file (make oldconfig dep all install modules modules_install).

Thanks,
	Miles

