Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266878AbUGLP43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266878AbUGLP43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 11:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUGLP43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 11:56:29 -0400
Received: from mproxy.gmail.com ([216.239.56.250]:16569 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266878AbUGLP4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 11:56:25 -0400
Message-ID: <4d8e3fd304071208566280e89b@mail.gmail.com>
Date: Mon, 12 Jul 2004 17:56:14 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: Linux 2.6.8-rc1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040712154204.GS4701@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org> <4d8e3fd3040712023469039826@mail.gmail.com> <20040712154204.GS4701@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2004 17:42:04 +0200, Adrian Bunk <bunk@fs.tum.de> wrote:
> On Mon, Jul 12, 2004 at 11:34:59AM +0200, Paolo Ciarrocchi wrote:
> > On Sun, 11 Jul 2004 11:29:44 -0700 (PDT), Linus Torvalds
> > <torvalds@osdl.org> wrote:
> > >
> > > Ok, there's been a long time between "public" releases, although the
> > > automated BK snapshots have obviously been keeping people up-to-date.
> > > Sorry about that, I blame mainly moving boxes and stuff around...
> >
> > Maybe I'm just missing the whole point but I wonder if we could define
> > a series of 'test' a version should pass before being marked as -rc ir
> > final.
> >
> > Now that we have the automated BK snapshots the "public" release seems
> > to be a minor milestone in the process.
> >
> > I would like to see ltp test suite, OSDL's compile stats and OSDL
> > benchmarking as part of the release process.
> >
> > Does it make sense ?
> 
> Unless he really knows what he's doing, no user should use anything
> other than the actual releases (i.e. 2.6.7, 2.6.8, 2.6.9,...).

I agree.

> OSDL does some tests for any -rc and many other people like me do other
> testing. Besides this, most patches already got similar treatment in
> -mm. This might not be a base for an ISO 9000 certificate, but it seems
> to be sufficietely working for finding most problems before the acttual
> release.

OSDL does some test for any -rc but the results of these tests don't affect
the release process. At least not in an official way.
 
> It would be more important if Linus would release one last -rc that will
> be released unchanged (except for EXTRAVERSION a few days later to catch
> bugs in last minute changes. This might catch more problems like the JFS
> compile problem in 2.6.7.

Right,
and in those days may be OSDL could run the testsuite we are discussing about.

ciao, Paolo
 
-- 
paoloc.doesntexist.org
