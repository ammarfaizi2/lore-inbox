Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261408AbRETELh>; Sun, 20 May 2001 00:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbRETEL1>; Sun, 20 May 2001 00:11:27 -0400
Received: from www.wen-online.de ([212.223.88.39]:25618 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261408AbRETELT>;
	Sun, 20 May 2001 00:11:19 -0400
Date: Sun, 20 May 2001 06:10:58 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: CML2 <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: Brown-paper-bag bug in m68k, sparc, and sparc64 config files
In-Reply-To: <20010519181026.A23730@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0105200607330.698-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 May 2001, Eric S. Raymond wrote:

> This bug unconditionally disables a configuration question -- and it's
> so old that it has propagated across three port files, without either
> of the people who did the cut and paste for the latter two noticing it.
>
> This sort of thing would never ship in CML2, because the compiler
> would throw an undefined-symbol warning on BLK_DEV_ST.  The temptation
> to engage in sarcastic commentary at the expense of people who still
> think CML2 is an unnecessary pain in the butt is great.  But I will
> restrain myself.  This time.

Erm.. if this bug is _that old_ and nobody noticed, isn't the right
fix to just delete the dead option?

	-Mike

