Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTK1UZw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 15:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263427AbTK1UZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 15:25:52 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:22034 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263424AbTK1UZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 15:25:51 -0500
From: Sam Ravnborg <sam@ravnborg.org>
To: "Adam Kropelin" <akropel1@rochester.rr.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Parallel build not working since -test6?
Date: Fri, 28 Nov 2003 21:26:59 +0100
User-Agent: KMail/1.5.4
Cc: <sam@ravnborg.org>
References: <02d801c3b474$e09e42a0$02c8a8c0@steinman>
In-Reply-To: <02d801c3b474$e09e42a0$02c8a8c0@steinman>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311282126.59634.sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 November 2003 00:27, Adam Kropelin wrote:
> Lately I've noticed my kernel compilations taking longer than usual.
> Tonight I finally realized the cause... Parallel building (i.e. make -jN)
> is no longer working for me. I traced it back and the last kernel it worked
> in was -test5. It ceased working in -test6.
It works for me, and for sure it works for most others. Otherwise I would
have seen lot of complaints like yours.
I recall one similar post, and the person in question used a homegrown
script that caused the problems.

Could you try to post:
a) Exact command used when building the kernel.
b) Output of kernel compile [first 100 lines] after a make clean

This may give me a hint of what is wrong.

	Sam

