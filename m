Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311564AbSDDUeu>; Thu, 4 Apr 2002 15:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311575AbSDDUel>; Thu, 4 Apr 2002 15:34:41 -0500
Received: from ns.suse.de ([213.95.15.193]:275 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311564AbSDDUe2>;
	Thu, 4 Apr 2002 15:34:28 -0500
Date: Thu, 4 Apr 2002 22:34:25 +0200
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Larry McVoy <lm@bitmover.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.8-pre1
Message-ID: <20020404223425.K11833@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Larry McVoy <lm@bitmover.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020403195445.U17549@work.bitmover.com> <Pine.LNX.4.33.0204041203440.14206-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 12:12:07PM -0800, Linus Torvalds wrote:
 > Anyway: of the 147 patches, 125 were merges from Dave Jones (only 123 are
 > marged as such - two were re-attributed by me by hand by editing the
 > emails directly).

Quite a few that got to you via Jeff's bk tree were also regular GNU
patches from me. I think the total yesterday was over 200 patches pushed
from me. Who still thinks Linus doesn't scale ? 8-)

 > And of those 123 changesets marked as coming from Dave, most were
 > obviously written by others, and Dave acted as integrator (which is not
 > unimportant, of course - 99% of what I do myself is only integration these
 > days).

As a sidenote, I don't mind being attributed in the csets as the source
of where the patch came from, but where I remember/know where the patch
is coming from, I'm making a note in the msg that goes along with it
to the effect of 'Originally from : Joe Hacker'.

 > So the statistics get skewed by details like this - if is only a partial
 > map of who actually _wrote_ the patch.

If I stuck to a common way of marking the original author, you could
probably enhance your merging scripts to suck that out and attribute
$whoever instead. This only works for patches where I 
a. Remember where they came from
b. Are not parts of large "suck everything from latest 2.4.x-pre"
   (In most cases, I have no idea who the original author is unless
    they were mentioned in the changelog, or I spotted the mail on l-k)
c. I remember to add the magic tag
d. I don't typo the tag/get it wrong.

With Marcelo using bk these days, is it possible that you can cherry
pick certain csets from his bk tree ? If so, it may be that as time
goes on, the need for my forward ports becomes less useful.
Though I'm guessing this would end up more work for you having to
sit clicking around in bk's conflict resolution tool.
Could work well for the simple bits though.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
