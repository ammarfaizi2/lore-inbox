Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293517AbSBZEwY>; Mon, 25 Feb 2002 23:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293518AbSBZEwO>; Mon, 25 Feb 2002 23:52:14 -0500
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:28550 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S293517AbSBZEwC>;
	Mon, 25 Feb 2002 23:52:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Shawn Starr <spstarr@sh0n.net>, Linux <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in =?iso-8859-1?q?the	tree?=
Date: Sun, 24 Feb 2002 06:44:36 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200202260135.18913.Dieter.Nuetzel@hamburg.de> <1014686150.18834.2.camel@coredump> <4360000.1014687125@flay>
In-Reply-To: <4360000.1014687125@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16erSe-0001Qn-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 26, 2002 02:32 am, Martin J. Bligh wrote:
> > Not to begin the flamewar, but no thanks. rmap-12f blows -aa away AFAIK
> > on this P200 w/ 64MB ram.
> 
> rmap still sucks on large systems though.

But this is not a fundamental issue, it's implementation.  Whereas non-rmap
will always suck on large systems, for fundamental reasons that are unrelated
to the quality of the implementation.

> I'd love to see rmap
> in the main kernel, but it needs to get the scalability fixed first.

Yes.

> The main problem seems to be pagemap_lru_lock ... Rik & crew 
> know about this problem, but let's give them some time to fix it 
> before rmap gets put into mainline ....

Yes, yes and yes.

-- 
Daniel
