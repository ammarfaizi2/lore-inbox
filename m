Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272214AbRH3N07>; Thu, 30 Aug 2001 09:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272215AbRH3N0j>; Thu, 30 Aug 2001 09:26:39 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:43024 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S272214AbRH3N0f>; Thu, 30 Aug 2001 09:26:35 -0400
Date: Thu, 30 Aug 2001 09:26:42 -0400 (EDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: David Woodhouse <dwmw2@infradead.org>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war 
In-Reply-To: <19468.999177442@redhat.com>
Message-ID: <Pine.LNX.4.33.0108300925340.8855-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, David Woodhouse wrote:

> 
> 
> ionut@cs.columbia.edu said:
> > ... unless of course the programmer used an unsigned char when what he
> >  really wanted was a signed char. But in that case even your typed min
> >  macro won't save him, because what should the forced type be anyway?
> > If  it's "int", nothing changes; if it's "signed char", you risk
> > truncating  the int. So you end up with something like
> 
> > 	min(int, a, (char)b) 
> 
> If the programmer wrote that when he really wanted a signed char, he has 
> more fundamental brokenness to worry about than the min/max fun.

Which is precisely my point, we're in violent agreement here...

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

