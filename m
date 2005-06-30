Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbVF3WuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbVF3WuH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 18:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbVF3WuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 18:50:07 -0400
Received: from mail.dif.dk ([193.138.115.101]:21484 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S263089AbVF3WuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 18:50:01 -0400
Date: Fri, 1 Jul 2005 00:56:01 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       =?ISO-8859-1?Q?Gustavo_Guillermo_P=E9rez?= <gustavo@compunauta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] build just one driver
In-Reply-To: <Pine.LNX.4.60.0506302149500.8278@poirot.grange>
Message-ID: <Pine.LNX.4.62.0507010053390.2858@dragon.hyggekrogen.localhost>
References: <200506282309.20296.gustavo@compunauta.com>
 <9a874849050629122775d0542c@mail.gmail.com> <Pine.LNX.4.60.0506302149500.8278@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2005, Guennadi Liakhovetski wrote:

> On Wed, 29 Jun 2005, Jesper Juhl wrote:
> > On 6/29/05, Gustavo Guillermo P?rez <gustavo@compunauta.com> wrote:
> > > How can I build just one driver without building everthing or removing the
> > > others from the config.
> > 
> > See "make help" : 
> > 
> > $ make help | grep "dir/"
> >   dir/            - Build all files in dir and below
> >   dir/file.[ois]  - Build specified target only
> Unfortunately, one cannot do make dir/module.ko... Would it be too 
> difficult to add?

Hmm, I suspect people would find that useful. 
I'm not making any promises, but I might take a look at adding that later, 
on the other hand I don't have much time at the moment, so maybe I 
won't...


-- 
Jesper


