Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTKDVDS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 16:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbTKDVDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 16:03:18 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:1029
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262601AbTKDVDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 16:03:13 -0500
Date: Tue, 4 Nov 2003 13:03:10 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Debian Kernels was: 2.6.0test9 Reiserfs boot time "buffer layer error at fs/buffer.c:431"
Message-ID: <20031104210310.GA1068@matchmail.com>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20031029141931.6c4ebdb5.akpm@osdl.org> <E1AGCUJ-00016g-00@gondolin.me.apana.org.au> <20031101233354.1f566c80.akpm@osdl.org> <20031102092723.GA4964@gondor.apana.org.au> <20031102014011.09001c81.akpm@osdl.org> <20031102210942.GA9635@gondor.apana.org.au> <20031103112008.5ac6a6cc.skraw@ithnet.com> <3FA75F05.8070903@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA75F05.8070903@namesys.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Stephan von Krawczynski wrote:
> >I really send prayers for the day distros will stop building own kernels 
> >for
> >they only reduce the installed test base for kernels as a whole by 
> >splitting it
> >up in numerous kernel versions...

On Tue, Nov 04, 2003 at 12:10:45AM -0800, Hans Reiser wrote:
> Amen.  Since Debian is a not for profit organization, it really should 
> not be doing this.

Ok guys, this has gotten pretty far OT. 

Being a debian user since Dec 1998 (first and only distro), I might be able
to explain some things.

Debian is not trying to relicense any GPLed code, but it does have another
guide it follows as to what it will include in a Debian release; the DFSG -
Debian Free Software Guide.

Some licenses that are considered compatible with the GPL on LKML are not in
the DFSG.  I believe the latest one is the GNU Documentation License, but
that's still being argued about...

I have been using official Debian packages for everything except for the
kernel.  First because I wanted to test the -pre, -mm, -aa, and other
kernels, and second that I didn't like the vesafb that was turned on by
default.

I'd love to see the 'initrd on cramfs' patch merged into the vanilla kernel
though. :)

Now, let's try to get it back On Topic...

There was a bug in one of the released Debian kernels, and do you think this
hasn't happened with Redhat, SuSe, or Mandrake?  Just because Debian is
completely OSS and maintained mostly by unpaid volunteers, that shouldn't keep
them from having a seperate tree like everyone else.

I'd like to see each vendor tree as small as possible.  And Debian's may be
the smallest vendor tree AFAIK they haven't merged XFS into their 2.4 tree.
But think about this.  Linus wants to see features have a large user base
before merging many outside kernel projects, and vendor kernels are one way
to show a project is popular.

It's bad enough that there are over 5 other distros based on Debian, and
only now are any of them contributing back to the installer, and maybe we
will get some hardware detection out of Knoppix!

So, has this bug been fixed?  And if not, what other patches are needed to
test more?
