Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbTIXAgr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 20:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbTIXAgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 20:36:47 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19347
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261205AbTIXAgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 20:36:44 -0400
Date: Wed, 24 Sep 2003 02:36:52 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
Message-ID: <20030924003652.GI16314@velociraptor.random>
References: <20030923221528.GP1269@velociraptor.random> <Pine.LNX.4.44.0309231524160.24527-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309231524160.24527-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 03:54:22PM -0700, Linus Torvalds wrote:
>   [ Bad analogy time ]
> 
> You're acting like a husband that has a wife that refuses to use make-up,
> and thinks that everybody else should have ugly wives too, and calls them 
> whores for being prettier.
> 
> Actually, in the CVS analogy, I don't think it's that your wife refuses to
> use make-up, but that make-up doesn't actually help.
> 
>   [ Ok, let's see just _how_ badly I get flamed for that analogy. I
>     admit, it really sucks, and is tasteless to boot. My bad. ]

amusing ;)

well, following your bad analogy time, with software we can do the
equivalent of changing the dna, that can fix the problem unlike than
markup. So even starting from a very bad dna may not be a disaster as
far as there's a critical mass behind it, able to eventually rewrite it
from scratch. sure if we could choose the dna of a beautiful woman, it
would be easier, but we don't have much choice (cvs/svn).  either that
or we start from scratch.

> because we've got religion, and this doesn't contain any cow-meat".

this is not religion this is primarly a law matter from my point of view.

AFIK it's illegal for me to use bitkeeper, because I'm not giving up the
freedom to fix bugs in cvs or hack subversion, like the one that I'm
going to fix to avoid losing the domain, period.

It's a pleasure for me to be able to very seldom fix an annoying bug
once in a while in some random app, that nobody else cared about or
noticed. It doesn't happen frequently, but it's one of the things I also
like of using open source.

And secondly I prefer "open" to "immediatly better" or even to
"immediatly so much better". Again, not because of religion (at least I
don't feel it that way), but because of a better long term business
investment. What you call religion I call long term investment.  yeah,
it maybe too long term, but I won't take the risk of trading it with the
freedom of innovating in this area (even if I may never will).

You're right I should provide new code, and avoid comments on the a bit
inferior info in bkcvs (that Larry nicely offered to even improve after
cvs gets properly fixed), but I had no real interest in this area todate
and my job keeps most of my time full already and that's higher
priority. So I'm trying to at least raise the issue to see if somebody
else shares my view, and maybe in more people it'll be easier to write
code. I'm not complaining anything to Larry, quite the opposite, he was
very annoyed by my signature, but I respect Larry and the signature has
really nothing directly against him or bitkeeper. I'm advertizing the
open links, that were not posted into any webpage or anywhere else, and
I tought they deserved to be better known.

As for the merging with mainline, these patches were merged from 2.4.22
to 2.4.23pre5 (not all of them have been developed from me):

Only in 2.4.22aa1: 00_config-smp-1
Only in 2.4.22aa1: 00_copy-namespace-1
Only in 2.4.22aa1: 00_panic-console-switch-1
Only in 2.4.22aa1: 00_pgt-cache-leak-2
Only in 2.4.22aa1: 00_read_full_page-get_block-err-2
Only in 2.4.22aa1: 00_sk98lin_2.4.22-20030902-1.gz
Only in 2.4.22aa1: 05_vm_03_vm_tunables-4
Only in 2.4.22aa1: 05_vm_05_zone_accounting-2
Only in 2.4.22aa1: 05_vm_06_swap_out-3
Only in 2.4.22aa1: 05_vm_07_local_pages-4
Only in 2.4.22aa1: 05_vm_09_misc_junk-3
Only in 2.4.22aa1: 05_vm_16_active_free_zone_bhs-1
Only in 2.4.22aa1: 05_vm_17_rest-10
Only in 2.4.22aa1: 70_xfs-sysctl-3
Only in 2.4.22aa1: 9999900_request-firmware-1

I know this time more patches have been merged than in the previous
kernels (in this case some of the vm enhacements), but almost the same
number gets regularly merged into mainline in the other releases too.

You're wrong saying that all I care is my tree, I'm deeply careful in
keeping those patches in a way that can be merged with the minor
possible pain from the kernel maintainer, infact I hope Marcelo also was
confortable with that. My object is to get everything merged into
mainline. Personally I wish my tree would be empty.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
