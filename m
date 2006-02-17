Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWBQThl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWBQThl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 14:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWBQThl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 14:37:41 -0500
Received: from [217.7.64.195] ([217.7.64.195]:2192 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S1750873AbWBQThk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 14:37:40 -0500
From: Ernst Herzberg <earny@net4u.de>
Reply-To: earny@net4u.de
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc3 macromedia flash regression...
Date: Fri, 17 Feb 2006 20:37:36 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <200602170508.52712.list-lkml@net4u.de> <20060216231014.6c2ae214.akpm@osdl.org>
In-Reply-To: <20060216231014.6c2ae214.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602172037.36266.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Freitag 17 Februar 2006 08:10, Andrew Morton wrote:
> Ernst Herzberg <list-lkml@net4u.de> wrote:
> > .... or not regession, that's the question.
> >
> >  2.6.16-rc2 works without problems.
> >
> >  With -rc3 a .swf that opens a ip connection back to the server takes
> > ages to load. strace shows that the player hangs for long times in
> > select().
> >
> >  Digging through the changelog brings up
> >
> >  commit 643a654540579b0dcc7a206a4a7475276a41aff0
> >  Author: Andrew Morton <akpm@osdl.org>
> >  Date:   Sat Feb 11 17:55:52 2006 -0800
> >
> >      [PATCH] select: fix returned timeval
>
> Thanks for working that out.
>
> Are you able to send along the relevant parts of the strace output, so
> we see the select() inputs and outputs?

The straces are available at

http://dev.net4u.de/~earny/flash_regression/

If someone want to debug this by itself should contact me private, i will 
then setup an URL with the problematic swf.

Thanks

<earny/>
