Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130824AbRC0IPe>; Tue, 27 Mar 2001 03:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130820AbRC0IPY>; Tue, 27 Mar 2001 03:15:24 -0500
Received: from adsl-64-163-64-75.dsl.snfc21.pacbell.net ([64.163.64.75]:18961
	"EHLO konerding.com") by vger.kernel.org with ESMTP
	id <S130770AbRC0IPM>; Tue, 27 Mar 2001 03:15:12 -0500
Message-ID: <3AC04BAC.C21E302@konerding.com>
Date: Tue, 27 Mar 2001 00:13:32 -0800
From: David Konerding <dek_ml@konerding.com>
X-Mailer: Mozilla 4.73 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: "mount -o loop" lockup issue
In-Reply-To: <Pine.LNX.4.21.0103270229310.8261-100000@imladris.rielhome.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rik van Riel wrote:

> On Mon, 26 Mar 2001, David Konerding wrote:
>
> > It's a bug in Linux 2.4.2, fixed in later versions.
> > Regression/quality control testing would have caught this, but the
> > developers usually just break things and wait for people to complain
> > as their "Regression" testers.
>
> As said before, we're interested in people willing to do regression
> tests on the kernel. Unfortunately, not all that many testers have
> stepped forward and not all that many artificial tests are being run.

No, the point is that the linux developers should regression test their
code BEFORE
releasing it to the public as a version like "2.4.2".  When I see a
version like "2.4.2", I have an expectation that all the stupid little
problems (like mounting loopback filesystem) have already been found.

It's even worse that these are obvious, simple bugs (like the "NFS doesn't
work over reiserfs
because somebody changed the VFS layer and didn't fix any filesystems but
ext2" that I reported a while ago) which would have been caught by a
little testing.

Now, don't even get me started on how the developers are fixing every
legitimate bug found by CHECKER when they refused to put a debugger into
the kernel "because a good programmer finds their bug by studying the
code"-- well, obviously, you didn't find a lot of bugs by studying the
code.

I've been using Linux for something like 6-7 years now, quite faithfully.
I've been very impressed with
many of its facilities, and the improvements to the kernel (which I've
compiled since 0.99) have been astounding.  But the attitude that "many
eyes make all bugs shallow" and "let the users test the code for us" just
don't hold up.  For the former, clearly, many eyes didn't find a lot of
basically obvious bugs, for the latter, it's just impolite.

