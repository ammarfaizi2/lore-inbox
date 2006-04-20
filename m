Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWDTELF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWDTELF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 00:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWDTELF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 00:11:05 -0400
Received: from web36608.mail.mud.yahoo.com ([209.191.85.25]:56971 "HELO
	web36608.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751258AbWDTELE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 00:11:04 -0400
Message-ID: <20060420041059.21278.qmail@web36608.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Wed, 19 Apr 2006 21:10:59 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
To: linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
In-Reply-To: <1145469670.24289.206.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Stephen Smalley <sds@tycho.nsa.gov> wrote:
 
> One would hope that particularly in the arena of
> security, sound judgment
> would be applied.  In this particular case, it isn't
> just security folks
> who are troubled by reliance on pathnames, and there
> are plenty of prior
> discussions on linux-fsdevel and linux-kernel
> describing the brokenness
> of path-based approaches.  Why would the answer be
> different now?

Just to be clear here, not everyone is comfortable
with the idea of a security "policy" that is
developed,
maintained, and stored independently of the kernel
and the applications to which it is applied.
The SELinux approach took a good deal of selling
within the community before it gained traction,
and a good many of the voices I've heard today
spoke out against SELinux in the beginning. It is
still far from universally regarded as the ultimate
solution.

> > Of course LSM will fit SELinux better than it fits
> > AppArmour, LSM has been adapted to fit the needs
> > of SELinux. 
> 
> This is a gross misrepresentation of the facts and
> history of LSM.

Perhaps. The SELinux community has made significant
contributions to the LSM effort might be a more
politic way to say it, but in the end the changes
made by the SELinux community were done for the
benefit of SELinux. This is only natural and to be
expected.

> LSM was jointly developed, and the initial VFS inode
> hooks were proposed by
> none other than the WireX folks, i.e. the developers
> of SubDomain/AppArmor.

Yes, I remember it well. The Bumper Patch of Fun
and the resulting Bruhaha over authoritative hooks
will feature prominently in my tell-all book.

> From that initial proposal, though the entire
> development of LSM, through the 2.5 development
> series after LSM was
> merged, and through the 2.6 stable series so far, no
> one from the
> AppArmor side has ever suggested a need to change
> the hooks to better accomodate their needs.

Now that's just not true. Crispin was very active in
the very early days. He didn't always get what he
wanted, but he certainly asked for it many times.

> Yet if you look at their implementation (and I
> have, have you?), you'll see that they have to go
> through contortions
> because the LSM interface is such a mismatch for
> what they do.  That
> isn't due to any "adaptations" for SELinux.

I am sure that LSM, being a community effort, can
evolve over time for AppArmour just as it has for
SELinux and any other user that invests (that's a
key) in the effort. SELinux has provided the lion's
share of value to LSM over the past couple years.
It is both appropriate and to be expected that LSM
has lost much of its independence from SELinux
under such circumstances.

> > SELinux wasn't always a good fit either. LSM
> > accomodated SELinux. Offer the same community
> > cooperation to other you have yourself received.
> 
> Community cooperation doesn't mean embracing unsound
> ideas.

It is well known that I am far from convinced
that the policy file basis of SELinux is sound.
Many people of demonstrated intelligence think
it is. Personally, I suspect that both Stephen
and Crispin are smarter than I am, and I believe
that both have value to add to the community with
the approaches they've developed. The same goes
for LIDS, LOMAX, other projects I've seen but
may not name.

Let's not chicken out. Linux is too young to get
stodgy.


Casey Schaufler
casey@schaufler-ca.com
