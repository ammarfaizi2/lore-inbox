Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281645AbRKZM1Z>; Mon, 26 Nov 2001 07:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281647AbRKZM1G>; Mon, 26 Nov 2001 07:27:06 -0500
Received: from web20508.mail.yahoo.com ([216.136.226.143]:30736 "HELO
	web20508.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S281645AbRKZM0u>; Mon, 26 Nov 2001 07:26:50 -0500
Message-ID: <20011126122649.51511.qmail@web20508.mail.yahoo.com>
Date: Mon, 26 Nov 2001 13:26:49 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: [RFC] 2.5/2.6/2.7 transition [was Re: Linux 2.4.16-pre1]
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The _real_ solution is to make fewer fundamental
changes
> between stable kernels, and that's a real solution
that I
> expect to become more and more realistic as the
kernel
> stabilizes. I already expect 2.5 to have a _lot_
less
> fundamental changes than the 2.3.x tree ever had -
the
> SMP scaliability efforts and page-cachification
between
> 2.2.x and 2.4.x is really quite a big change.

Well, I know this has been discussed several times,
but why
not having 2 stable trees : one for the average "joe"
user
which would include fixes and new features, and one
for
prod servers which will have only bugfixes, and quite
old, 
tested features, with less risks of regression. I
think that all
in all, current 2.4 kernels are fairly stable except,
perhaps
for a few, not so common, features. There are still
lots of
people who don't upgrade their 2.2 to 2.4 (or even old
2.4 to
newer 2.4) because of a "well known bug" in a feature
they
might even never use.

I'm myself used to build kernels from Alan's tree, on
which
I add several features (ipsec...), and backport
bugfixes from
more recent kernels (as far as my understanding can
go, of
course). When 2.4.14 went out, I was still using a
2.4.10ac12
+many fixes, but without any feature upgrade. I have
several
friends using my kernels because they find them more
stable
although I couldn't judge because they don't always
report
bugs as people do on LKML.

A very conservative branch could be maintained with
not 
much effort since we would only have to include new
fixes
(ok, sometimes you can't keep up and have to make the
step, that's why I jumped from 2.4.10ac to 2.4.13ac).
We
could even count failure and success reports for some 
features to help those paranoïd to decide which kernel
to
use.

Perhaps it's what distro makers do, but at least they
don't
announce their kernels on LKML as you, Alan, or Andrea
actually do.

I even may participate in this, given my very limited
time (ie,
if people are ready to wait 3 weeks without news, and 
accept sometimes completely broken kernels when I jump
from one major release to one other), but honnestly,
that's
not my primary goal.

Just my 2 euro-cents here,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Courrier : http://courrier.yahoo.fr
