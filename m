Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSHISGt>; Fri, 9 Aug 2002 14:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315259AbSHISGt>; Fri, 9 Aug 2002 14:06:49 -0400
Received: from dsl-213-023-043-103.arcor-ip.net ([213.23.43.103]:17038 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315200AbSHISGt>;
	Fri, 9 Aug 2002 14:06:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: large page patch (fwd) (fwd)
Date: Fri, 9 Aug 2002 20:08:23 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>, <frankeh@watson.ibm.com>,
       <davidm@hpl.hp.com>, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, <gh@us.ibm.com>,
       <Martin.Bligh@us.ibm.com>, <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0208091328240.23404-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0208091328240.23404-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17dEBT-0001OZ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 August 2002 18:31, Rik van Riel wrote:
> On Fri, 9 Aug 2002, Daniel Phillips wrote:
> > On Friday 09 August 2002 17:56, Linus Torvalds wrote:
> 
> > > Also, I think the jury (ie Andrew) is still out on whether rmap is worth
> > > it.
> >
> > Tell me about it.  Well, I feel strongly enough about it to spend the
> > next week coding yet another pte chain optimization.
> 
> Well yes, we've _seen_ that 2.4 -rmap improves system behaviour,
> but we don't have any tools to _quantify_ that improvement.
> 
> As long as the only measurable thing is the overhead (which may
> get close to zero, but will never become zero) the numbers will
> continue being against rmap.  Not because of rmap, but just
> because the overhead is the only thing being measured ;)

You know what to do, instead of moaning about it.  Just code up a test load 
that blatantly favors rmap and post the results.  In effect, that's what 
Andrew's 'doitlots' benchmark does, in the other direction.

-- 
Daniel
