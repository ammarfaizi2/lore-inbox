Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315883AbSFCXup>; Mon, 3 Jun 2002 19:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315910AbSFCXuo>; Mon, 3 Jun 2002 19:50:44 -0400
Received: from [63.204.6.12] ([63.204.6.12]:52650 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S315883AbSFCXuo>;
	Mon, 3 Jun 2002 19:50:44 -0400
Date: Mon, 3 Jun 2002 19:50:42 -0400 (EDT)
From: "Scott Murray" <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: Thunder from the hill <thunder@ngforever.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Subject: Re: [PATCH][2.5] Port opl3sa2 changes from 2.4
In-Reply-To: <Pine.LNX.4.44.0206031709370.3833-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.33.0206031923540.5598-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002, Thunder from the hill wrote:

> Hi,
>
> On Mon, 3 Jun 2002, Scott Murray wrote:
> > I think it would be better to wait until Zwane sends something to Alan
> > and/or Marcelo, as this patch is incorrect on a couple of levels.  See my
> > annotations below:
>
> His patch won't match for 2.5. I just adapted it, even though I've had a
> typo there.
[snip]
> As I mentioned, I was just porting it.

I gotta say, I'm a little lost as to why you're taking this upon yourself,
considering that Zwane is for all intents and purposes the maintainer now
instead of me, and he seems to be effectively pushing stuff into 2.5 via
the Alan -> Marcelo -> Dave Jones -> Linus scheme.  I would really prefer
that you let him submit a patch for this, as I'm pretty sure that the
addition of the isapnp_change_resource calls will break the driver for
anyone whose machine doesn't have DMA 0 available.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com



