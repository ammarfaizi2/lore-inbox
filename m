Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316644AbSE3OJO>; Thu, 30 May 2002 10:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316652AbSE3OJN>; Thu, 30 May 2002 10:09:13 -0400
Received: from as3-1-8.ras.s.bonet.se ([217.215.75.181]:38793 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id <S316644AbSE3OJM>;
	Thu, 30 May 2002 10:09:12 -0400
Subject: Re: KBuild 2.5 Impressions
From: Kenneth Johansson <ken@canit.se>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Keith Owens <kaos@ocs.com.au>
In-Reply-To: <3CF62020.2030704@evision-ventures.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 May 2002 16:08:55 +0200
Message-Id: <1022767735.4032.5.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-05-30 at 14:50, Martin Dalecki wrote:
> Daniel Phillips wrote:
> 
> > Along the way, old kbuild did the usual wrong things:
> > 
> >   - In the incremental build, 6 files rebuilt that should not have been
> > 
> >   - Once, when I interrupted the make dep, subsequent make deps would
> >     no longer work, forcing me to do make mrproper and start again.
> > 
> >   - Way too much output to the screen
> 
> Bull shit: make -s helps.

In that case it's way to little. In kbuild2.5 it's actually easy to spot
if the correct files get compiled after a change.

