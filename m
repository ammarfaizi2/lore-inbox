Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291041AbSAaM3j>; Thu, 31 Jan 2002 07:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291042AbSAaM3T>; Thu, 31 Jan 2002 07:29:19 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:46489 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S291041AbSAaM3M>;
	Thu, 31 Jan 2002 07:29:12 -0500
Date: Thu, 31 Jan 2002 13:28:30 +0100
From: David Weinehall <tao@acc.umu.se>
To: Ingo Molnar <mingo@elte.hu>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020131132830.W1735@khan.acc.umu.se>
In-Reply-To: <3C59353F.3080208@evision-ventures.com> <Pine.LNX.4.33.0201311515350.9106-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201311515350.9106-100000@localhost.localdomain>; from mingo@elte.hu on Thu, Jan 31, 2002 at 03:17:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 03:17:52PM +0100, Ingo Molnar wrote:
> 
> On Thu, 31 Jan 2002, Martin Dalecki wrote:
> 
> > And then we are still just discussing here how to get things IN. But
> > there apparently currently is nearly no way to get things OUT of the
> > kernel tree. Old obsolete drivers used by some computer since
> > archeologists should be killed (Atari, Amiga, support, obsolete
> > drivers and so on). Just let *them* maintains theyr separate kernel
> > tree...
> 
> 'old' architectures do not hinder development - they are separate, and
> they have to update their stuff. (and i think the m68k port is used by
> many other people and not CS archeologists.) Old drivers are not a true
> problem either - if they dont compile that's the problem of the
> maintainer. Occasionally old drivers get zapped (mainly when there is a
> new replacement driver).

To testify that even really old hardware is used, I recently received a
patch for 2.0.xx to add autodetection for wd1002s-wx2 in the
xd.c-driver. Not particularly recent hardware, but the person who sent
the patch uses it. Why deny him usage of his hardware when it doesn't
intrude upon the rest of the codebase?


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
