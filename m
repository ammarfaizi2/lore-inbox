Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131289AbRC0Nux>; Tue, 27 Mar 2001 08:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131296AbRC0Nue>; Tue, 27 Mar 2001 08:50:34 -0500
Received: from smtp.primusdsl.net ([209.225.164.93]:6419 "EHLO
	mailhost.digitalselect.net") by vger.kernel.org with ESMTP
	id <S131289AbRC0NuW>; Tue, 27 Mar 2001 08:50:22 -0500
Date: Tue, 27 Mar 2001 08:51:42 -0500
From: James Lewis Nance <jlnance@intrex.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel QA
Message-ID: <20010327085142.A982@bessie.dyndns.org>
In-Reply-To: <Pine.LNX.4.21.0103270229310.8261-100000@imladris.rielhome.conectiva> <3AC04BAC.C21E302@konerding.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AC04BAC.C21E302@konerding.com>; from dek_ml@konerding.com on Tue, Mar 27, 2001 at 12:13:32AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2001 at 12:13:32AM -0800, David Konerding wrote:

> No, the point is that the linux developers should regression test their
> code BEFORE
> releasing it to the public as a version like "2.4.2".  When I see a
> version like "2.4.2", I have an expectation that all the stupid little
> problems (like mounting loopback filesystem) have already been found.

You bring up a good point.  We call the even branches the stable branches
and we do other things that promote the idea that people should be able to
download a 2.even.X kernel, install it on their machine, and expect it to
work.  I think we need to back away from this idea.  It seems to me that
the real (perhaps not the intended) function of kernel releases is keeping
kernel developers in sync.  Promoting the idea that they are thought to be
suitable for production use just gets us in trouble.

Instead I think we need to encourage people who want to use Linux,
rather than develop it, to use kernels from a distribution.  After all,
the distributors put a lot of effort into doing QA and putting together a
compatable system, we should leverage that.  We need to ensure that people
know that when they install the latest kernel from Linus, they are the QA.

Please note that I am not trying to say that we should not try and
make the kernels we release as good as possible.  It certainly makes
things a lot better for everyone if bugs dont get introduced by new
kernel versions.  I do think we need to be more explicit about exactly
what people should and should not be able to expect from a "Linus kernel".

Thanks,

Jim
