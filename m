Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317525AbSIIQwq>; Mon, 9 Sep 2002 12:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317540AbSIIQwq>; Mon, 9 Sep 2002 12:52:46 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:28094 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317525AbSIIQwp>;
	Mon, 9 Sep 2002 12:52:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Rik van Riel <riel@conectiva.com.br>
Subject: Re: LMbench2.0 results
Date: Mon, 9 Sep 2002 18:55:19 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@digeo.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       linux-kernel@vger.kernel.org
References: <E17oRCu-0006pL-00@starship> <312431072.1031563589@[10.10.2.3]>
In-Reply-To: <312431072.1031563589@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oRol-0006pi-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 18:26, Martin J. Bligh wrote:
> > An idea that's looking more and more attractive as time goes by is to
> > have a global config option that specifies that we want to choose the
> > simple way of doing things wherever possible, over the enterprise way.
> > We want this especially for embedded.  On low end processors, it's even
> > possible that the small way will be faster in some cases than the
> > enterprise way, due to cache effects.
> 
> Can't we just use the existing config options instead? CONFIG_SMP is
> a good start ;-) How many embedded systems with SMP do you have?

You need to look at it from the other direction: how do the needs of a
uniprocessor Clawhammer box differ from a Linksys adsl router?

-- 
Daniel
