Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283728AbRLEDnJ>; Tue, 4 Dec 2001 22:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283727AbRLEDm7>; Tue, 4 Dec 2001 22:42:59 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:38643
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S283726AbRLEDmt>; Tue, 4 Dec 2001 22:42:49 -0500
Date: Tue, 4 Dec 2001 19:42:43 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
Message-ID: <20011204194243.A24847@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <3C07CCCD.EA5E340A@randomlogic.com> <3C07D669.6C234598@mandrakesoft.com> <3C07E6D3.89A648AB@randomlogic.com> <20011201185312.P5770@khan.acc.umu.se> <3C094BAA.2A730D3B@randomlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C094BAA.2A730D3B@randomlogic.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 01:29:14PM -0800, Paul G. Allen wrote:
> David Weinehall wrote:
> > 
> > On Fri, Nov 30, 2001 at 12:06:43PM -0800, Paul G. Allen wrote:
> > 
> > [snip]
> > > A person shouldn't _need_ a decent editor to pick out the beginning/end
> > > of a code block (or anything else for that matter). The problem is
> > > exacerbated when such a block contains other blocks and quickly picking
> > > out where each begins/ends becomes tiresome. I _do_ have excellent
> > > editors, IDEs, and source code browsers and have used many different
> > > kinds in many different jobs. They still can not replace what the human
> > > eye and mind perceive.
> > 
> > Uhhhm, knowing when a code block begins? Usually you'll notice this from
> > the indentation. It's quite hard not to notice a tabsized shift
> > to the right...
> > 
> 
> Whitespace can be placed almost anywhere and the program will still
> compile. It can even be removed altogether. The only thing that keeps a
> program legible is proper formatting. It's real damn easy to miss a
> brace when the formatting is poor. And real easy to spend an hour trying
> to figure out where that missing brace goes, that is after the hour you
> spent figuring out that it was missing in the first place.
>

Then when you get your hands on code like this you have two bugs to fix:

1) The origional problem you wanted to code up

2) Fix the formatting.

I suggest (yes, more work) that you run the code through the code normalizer
for that project and then look at the code produced from that.

That way, you will be able to see the code blocks in a standard way.  As you
look at the formatted code, you can program in the old indentation format.

When you're done, you have two patches.  One with the origional fix, and
another with the formatting improvements.

You'll probably want to get a concensus of what the other developers in the
project have agreed upon before you submit the formatting patch.  Much the
way this thread may turn out...

mf

