Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWIVR1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWIVR1d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 13:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWIVR1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 13:27:33 -0400
Received: (root@vger.kernel.org) by vger.kernel.org id S964804AbWIVR1c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 13:27:32 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:56020 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750767AbWIVQPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 12:15:52 -0400
Subject: GPLv3 Position Statement
From: James Bottomley <James.Bottomley@SteelEye.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 11:15:50 -0500
Message-Id: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although this white paper was discussed amongst the full group of kernel
developers who participated in the informal poll, as you can expect from
Linux Kernel Developers, there was a wide crossection of opinion.  This
document is really only for discussion, and represents only the views of
the people listed as authors (not the full voting pool).

James

----------

The Dangers and Problems with GPLv3


James E.J. Bottomley             Mauro Carvalho Chehab
Thomas Gleixner            Christoph Hellwig           Dave Jones
Greg Kroah-Hartman              Tony Luck           Andrew Morton
Trond Myklebust             David Woodhouse

                               15 September 2006
                                     Abstract

           This document is a position statement on the GNU General Public
       License version 3 (in its current Draft 2 form) and its surrounding
       process issued by some of the Maintainers of the Linux Kernel
       speaking purely in their role as kernel maintainers. In no regard
       should any opinion expressed herein be construed to represent the
       views of any entities employing or being associated with any of the
       authors.

1 Linux and GPLv2

Over the past decade, the Linux Operating System has shown itself to be far
and away the most successful Open Source operating system in history.
However, it certainly wasn't the first such open source operating system
and neither is it currently the only such operating system. We believe that
the pre-eminent success of Linux owes a great part to the dynamism and
diversity of its community of contributors, and that one of the catalysts
for creating and maintaining this community is the development contract as
expressed by GPLv2.

    Since GPLv2 has served us so well for so long, and since it is the
foundation of our developer contract which has helped propel Linux to the
successes it enjoys today, we are extremely reluctant to contemplate
tampering with that licence except as bug fixes to correct exposed problems
or updates counter imminent dangers. So far, in the whole history of GPLv2,
including notable successes both injunctively and at trial, we have not
found any bugs significant enough to warrant such corrections.


2 Linux, the Kernel and the Open Source Universe

Linux Distributions, as the Free Software Foundation (FSF) has often
observed, don't only contain the kernel; they are composed of a
distribution of disparate open source components of which the kernel is
only a part (albeit a significant and indispensable part) which
collectively make up a useful and usable system. Thus, Linux as installed
by the end user, is critically dependent on entities, known as
distributions, who collect all of the necessary components together and
deliver them in a tested, stable form. The vast proliferation of Open
Source Licences complicates the job of these distributions and forces them
to spend time checking and assessing the ramifications of combining
software packages distributed under different (and often mutually
incompatible) licences--indeed, sometimes licensing consideration will be
sufficient to exclude a potential package from a distribution altogether.

    In deference to the critical role of distributions, we regard reducing
the Open Source licensing profusion as a primary objective. GPLv2 has
played an important role in moving towards this objective by becoming the
dominant Licence in the space today, making it possible to put together a
Linux Distribution from entirely GPLv2 components and thus simplify the
life of a distributor. Therefore, we believe that any update to GPLv2 must
be so compelling as to cause all projects currently licensed under it to
switch as expediently as possible and thus not fragment the currently
unified GPLv2 licensed ecosystem.


3 Linux and Freedom

Another of the planks of Linux's success rests squarely on the breadth and
diversity of its community of contributors and users, without whom we
wouldn't have the steady stream of innovation which drives our movement
forward. However, an essential element of this is the fact that individuals
with disparate (and sometimes even competing) objectives can still march
together a considerable distance to their mutual benefit. This synergy of
effort, while not compromising dissimilar aims, is one of the reasons Linux
manages to harness the efforts of not only motivated developers but also
corporate and commercial interests. This in turn is brought about by a
peculiar freedom enshrined in the developer contract as represented by
GPLv2, namely the freedom from binding the end use of the project. Without
this freedom, it would be much more difficult to satisfy the objectives of
the contributors, since those objectives often have expression in terms of
the end use to which they wish to put the particular project. Therefore, in
order to maintain the essential development synergy and consequent
innovation stream it provides to Linux, we could not countenance any change
to the GPL which would jeopardise this fundamental freedom.


4 Pivotal Role of the Free Software Foundation

We have acknowledged before, projects controlled by the FSF (especially
gcc, binutils and glibc) are essential components of every shipping Linux
distribution. However, we also take note of the fact that the FSF operates
very differently from Linux in that it requires assignment of copyright
from each and every one of the thousands of contributors to its code
base. These contributions have been given to the FSF not as a tribute to do
with as it will but under a solemn trust, as stated in article 9 of GPLv2,
only to licence the code under versions of the GPL that "... will be
similar in spirit to the present version". We, like all the individual
contributors to GNU projects, have taken that trust at face value and
accorded the FSF a special role in the Open Source Universe because of
it. It goes without saying that any updates to GPLv2 must be completely in
accord with the execution of that trust.


5 GPLv3 and the Process to Date

The current version (Discussion Draft 2) of GPLv3 on first reading fails
the necessity test of section 1 on the grounds that there's no substantial
and identified problem with GPLv2 that it is trying to solve.

    However, a deeper reading reveals several other problems with the
current FSF draft:

5.1     DRM Clauses

Also referred to as the "Tivoisation" clauses.

    While we find the use of DRM by media companies in their attempts to
reach into user owned devices to control content deeply disturbing, our
belief in the essential freedoms of section 3 forbids us from ever
accepting any licence which contains end use restrictions. The existence of
DRM abuse is no excuse for curtailing freedoms.

    Further, the FSF's attempts at drafting and re-drafting these
provisions have shown them to be a nasty minefield which keeps ensnaring
innocent and beneficial uses of encryption and DRM technologies so, on such
demonstrated pragmatic ground, these clauses are likewise dangerous and
difficult to get right and should have no place in a well drafted update to
GPLv2.

    Finally, we recognise that defining what constitutes DRM abuse is
essentially political in nature and as such, while we may argue forcefully
for our political opinions, we may not suborn or coerce others to go along
with them. Therefore, attempting to write these type of restrictions into
GPLv3 and then relicense all FSF code under it is tantamount to co-opting
the work of all prior contributions into the service of the FSF's political
ends, and thus represents a fundamental violation of the trust outlined in
section 4.

5.2     Additional Restrictions Clause

As we stated in section 2 one of the serious issues in Open Source is too
many licences. The additional restrictions section in the current draft
makes GPLv3 a pick and choose soup of possible restrictions which is going
to be a nightmare for our distributions to sort out legally and get
right. Thus, it represents a significant and unacceptable retrograde step
over GPLv2 and its no additional restrictions clause.

     Further, the additional restrictions create the possibility of
fragmentation of the licensing universes among particular chosen
restrictions, which then become difficult to combine and distribute
(because of the need for keeping track of the separate restrictions). Thus,
we think this potential for fragmentation will completely eliminate the
needed compulsion to move quickly to a new licence as outlined in section 2

5.3     Patents Provisions

As drafted, this currently looks like it would potentially jeopardise the
entire patent portfolio of a company simply by the act of placing a GPLv3
licensed programme on their website. Since the Linux software ecosystem
relies on these type of contributions from companies who have lawyers who
will take the broadest possible interpretation when assessing liability, we
find this clause unacceptable because of the chilling effect it will have
on the necessary corporate input to our innovation stream.

     Further, some companies who also act as current distributors of Linux
have significant patent portfolios; thus this clause represents another
barrier to their distributing Linux and as such is unacceptable under
section 2 because of the critical reliance our ecosystem has on these
distributions.


6 Conclusions

The three key objections noted in section 5 are individually and
collectively sufficient reason for us to reject the current licence
proposal. However, we also note that the current draft with each of the
unacceptable provisions stripped out completely represents at best marginal
value over the tested and proven GPLv2. Therefore, as far as we are
concerned (and insofar as we control subsystems of the kernel) we cannot
foresee any drafts of GPLv3 coming out of the current drafting process that
would prove acceptable to us as a licence to move the current Linux Kernel
to.

    Further, since the FSF is proposing to shift all of its projects to
GPLv3 and apply pressure to every other GPL licensed project to move, we
foresee the release of GPLv3 portends the Balkanisation of the entire Open
Source Universe upon which we rely. This Balkanisation, which will be
manifested by distributions being forced to fork various packages in order
to get consistent licences, has the potential to inflict massive collateral
damage upon our entire ecosystem and jeopardise the very utility and
survival of Open Source. Since we can see nothing of sufficient value in
the current drafts of the GPLv3 to justify this terrible cost, we can only
assume the FSF is unaware of the current potential for disaster of the
course on which is has embarked. Therefore, we implore the FSF to
re-examine the consequences of its actions and to abandon the current GPLv3
process before it becomes too late.

