Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVG1VLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVG1VLk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 17:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVG1VJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 17:09:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3030 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262296AbVG1VHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 17:07:54 -0400
Date: Thu, 28 Jul 2005 17:07:38 -0400
From: Dave Jones <davej@redhat.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, Jaroslav Kysela <perex@suse.cz>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [ALSA PATCH] 1.0.9b+
Message-ID: <20050728210738.GC2231@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
	Jaroslav Kysela <perex@suse.cz>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, tiwai@suse.de
References: <Pine.LNX.4.61.0507281546040.8458@tm8103.perex-int.cz> <20050728102525.234e6511.akpm@osdl.org> <1122577563.2772.17.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122577563.2772.17.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 03:06:02PM -0400, Lee Revell wrote:

 > > The git-alsa.patch in -mm which I obtain from
 > > master.kernel.org:/pub/scm/linux/kernel/git/perex/alsa-current.git is
 > > empty.  So we're now wanting to merge 4,000 lines of unreviewed code which
 > > hasn't been tested in -mm at approximately the -rc4 stage.
 > 
 > Lots of people install ALSA independently from the kernel (like all the
 > audio oriented distro users), probably a lot more than run -mm, so it's
 > not completely unreviewed.

There's a big difference between 'unreviewed' and 'untested'.
With drivers that support n variants of a piece of hardware,
hearing back that a driver works fine from someone isn't really
worth anything if the changes break for all the other users
of that driver that have a different variant, which haven't tested it yet.

We have a testing/review process in place, attempts to short-circuit
it should be prevented. Especially from a subsystem that
historically has had a number of issues wrt regressions each release.

		Dave

