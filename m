Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135855AbREDFAd>; Fri, 4 May 2001 01:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135861AbREDFAX>; Fri, 4 May 2001 01:00:23 -0400
Received: from www.wen-online.de ([212.223.88.39]:5645 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S135867AbREDFAL>;
	Fri, 4 May 2001 01:00:11 -0400
Date: Fri, 4 May 2001 06:59:42 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: iso9660 endianness cleanup patch
In-Reply-To: <200105040151.f441pUw113980@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.33.0105040655200.470-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 May 2001, Albert D. Cahalan wrote:

> Pavel Machek writes:
>
> > It  should ot break anything. gcc decides its bad to inline it, so it
> > does not inline it. Small code growth at worst. Compiler has right to
> > make your code bigger or slower, if it decides to do so.
>
> Oh come on. The logical way:
>
> inline          Compiler must inline (only!) or report an error.

That's doable now.. if the code is otherwise warning free.

	-Mike

