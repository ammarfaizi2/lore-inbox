Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbTKPOP2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 09:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbTKPOP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 09:15:28 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:44975 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S262844AbTKPOP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 09:15:26 -0500
X-Sender-Authentication: net64
Date: Sun, 16 Nov 2003 15:15:22 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: mfedyk@matchmail.com, reiser@namesys.com, herbert@gondor.apana.org.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Debian Kernels was: 2.6.0test9 Reiserfs boot time "buffer layer
 error at fs/buffer.c:431"
Message-Id: <20031116151522.6ef9d2e1.skraw@ithnet.com>
In-Reply-To: <20031116130558.GB199@elf.ucw.cz>
References: <20031029141931.6c4ebdb5.akpm@osdl.org>
	<E1AGCUJ-00016g-00@gondolin.me.apana.org.au>
	<20031101233354.1f566c80.akpm@osdl.org>
	<20031102092723.GA4964@gondor.apana.org.au>
	<20031102014011.09001c81.akpm@osdl.org>
	<20031116130558.GB199@elf.ucw.cz>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Nov 2003 14:05:58 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> [...]
> > Just to avoid a false impression: I am in no way against debian project nor
> > do I say there is anything specifically bad about it. I am generally
> > disliking distros' ideas of having _own_ kernels. Commercial companies like
> > SuSE or Red Hat may find arguments for that which are commercially backed,
> > debian on the other hand can hardly argue commercially. From the community
> > point of view it is just nonsense. It means more work and less useable
> > feedback. Bugs is distro kernels are (always) the sole fault of their
> > respective maintainers because they actively decided _not_ to follow the
> > mainstream and made bogus patches. Why waste the appreciated work of
> > (unpaid) debian volunteers in this area? There are tons of other work left
> > with far more relevance for users than bleeding edge kernel patches...
> 
> 
> Debian is distibution; distributions are _expected_ to fix bugs (etc)
> in their packages.

I am just of the opposite opinion. It is a project maintainers' job to fix
bugs. A distributions' job is to _distribute_ packages in its pure sense.
Obviously people creating a distribution run across bugs while checking out the
projects to pack into their distro. So I very well agree they should do
_something_ about it, BUT this "something" is _not_ creating more or less
useful patches for their (and their customers) use, but get in contact with the
project maintainer and hand them the patches, look for their approval and
_then_ move the project into their distro. There is no sense in creating a
debian patched pppd, a SuSE patched pppd and a RH-patched pppd, altogether
different from the projects basic pppd. (This is not a real example, but only a
clarification of what I'd say is _the wrong way_ (tm))

> If distribution had all packages unmodified, it would be useless...

Just contrary I'd state that this would be the "perfect world", because this
would mean all projects are in perfect shape and all patches have gone to the
respective maintainers.

> So I'd expect all distros to have at least some changes in their
> kernel... the same way I expect distros to have some patches in
> midnight commander etc.

So you say midnight commanders' maintainer is an a**hole, or what?
If you think some project needs patches, then please talk to its maintainer (if
any), or get involved and become its maintainer...

I do think though, that there should be something in between, namely a place
where projects are hosted that (currently) have no maintainer, but where one
can send patches that are needed for some reason. This is a bit of a political
question, maybe OSDL can be such a place. Whatever the place is, it should be
independent to a degree.

> Of course it is good to keep the .diff as small as possible.

diffsize small is wanted.
diffsize zero is unwanted.
What kind of a logic is that?

Forgive me Pavel, that does not sound thoughtful to me.

Regards,
Stephan
