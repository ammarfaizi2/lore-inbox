Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSEaAal>; Thu, 30 May 2002 20:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSEaAak>; Thu, 30 May 2002 20:30:40 -0400
Received: from dsl-213-023-038-015.arcor-ip.net ([213.23.38.15]:5854 "EHLO
	starship") by vger.kernel.org with ESMTP id <S312962AbSEaAak>;
	Thu, 30 May 2002 20:30:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: KBuild 2.5 Impressions
Date: Fri, 31 May 2002 02:29:16 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Ion Badulescu <ionut@cs.columbia.edu>, Keith Owens <kaos@ocs.com.au>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205301704550.23527-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17DaI8-0007iQ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 May 2002 02:09, David Lang wrote:
> On Fri, 31 May 2002, Daniel Phillips wrote:
> don't forget that the kbuild2.5 patch was a lot smaller before keith was
> told to "go away and don't bother anyone until the speed problem is fixed"
> a large part of the fix was to use the mmapped db stuff that Larry McVoy
> made available instead of useing the standard db libraries on the system.

I haven't seen complaints about the size of the patch, there are plenty of
patches of similar size.  I've only seen the request to break it up, and
as I showed, it's not that hard, so...

Though I can certainly see why somebody who is weary from a long trip
could react badly to the suggestion that they should go take a further
hike around the block.

> one possible way to make this more 'incramental' would be to make a
> version of kbuild2.5 that used the standard db stuff and is 200% slower
> then the existing kbuild and then after it's accepted put in the patch to
> speed it up to where it's 17% faster (IIRC the numbers Daniel posted
> earlier today) by converting the db that's used. Somehow I doubt that
> crippling the speed mearly to make it 'incramental' would make many people
> happy.

The way I see it, all that's required with respect to the db is to give
it its own patch.  Out of regard to Larry, who contributed it, even make
it a BitKeeper patch ;-)

-- 
Daniel
