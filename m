Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136232AbRECIac>; Thu, 3 May 2001 04:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136230AbRECIaW>; Thu, 3 May 2001 04:30:22 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:55436 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136227AbRECIaE>;
	Thu, 3 May 2001 04:30:04 -0400
Date: Thu, 3 May 2001 04:29:59 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: Why recovering from broken configs is too hard
In-Reply-To: <20010503034755.A27693@thyrsus.com>
Message-ID: <Pine.GSO.4.21.0105030353120.15957-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 May 2001, Eric S. Raymond wrote:

> The obvious thing to try is to start with the configuration you have
> and try mutating the variables that occur in the broken constraint(s).
> Of course, there are 3^n of these where n is the number of distinct
> variables, so this is going to blow up really fast; 3, 9, 27, 81, 243
> and we ain't even to six symbols yet.  By the time we get to the
> twelve variables that could be linked by just *one* constraint, there
> are 531,441.  Even if you can check 500 configurations a second it's
> going to take 16 minutes just to get a candidate list.
> 
> But wait!  There's more!  If some of the variables participate
> in multiple constraints, the numbers get *really* large.  Worst-case
> you wind up having to filter 3^1976 or

<DSW>
I see your 3^1976 and raise "unsolvable". It's a special case
of termination problem, dontcha see.
</DSW>

Yes, generic problem is damn hard. The thing being, _this_ problem is
damn far from generic.

