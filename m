Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTENCTs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 22:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTENCTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 22:19:48 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:43886 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262805AbTENCTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 22:19:47 -0400
Date: Tue, 13 May 2003 22:32:33 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200305140232.h4E2WXF15208@devserv.devel.redhat.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
In-Reply-To: <mailman.1052866140.9783.linux-kernel2news@redhat.com>
References: <20030512155417.67a9fdec.akpm@digeo.com> <20030512155511.21fb1652.akpm@digeo.com> <1052834227.432.30.camel@dhcp22.swansea.linux.org.uk> <20030513163854.A27407@infradead.org> <20030513131754.7f96d4d0.akpm@digeo.com> <mailman.1052866140.9783.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, May 13, 2003 at 01:17:54PM -0700, Andrew Morton wrote:
> > But I do not view non-ia32 support as being a 2.6.0 requirement.  I'd be OK
> > with 2.6.0 working _only_ on ia32.  Other architectures will catch up when
> > they can.  The only core requirement is that 2.6.0 not contain gross
> > x86isms which make other ports impossible.

> Once we're into 2.6.x though, would it be unfeasable to hold off on
> final point releases until arch maintainers have sent in a 'make things
> work for this release' diff ? Ie, make rc's "strict bugfixes only, and
> arch updates" [...]

> Though, for some archs (sparc32 springs to mind), we may end up waiting
> quite a while, so perhaps just settle on a handful of 'to be kept
> up-to-date' archs ?

Why does the sparc(32) spring to mind, in particular?
It is likely to be in better shape than sh or mips.
I'm injured (not that anyone cares, but just for the record).

I agree with Andrew on the whole though. More, it's not about
being first tier architecture, or a second tier architecture.
It's about being up to date. I know at least one first tier
architecture which is fond of taking removed features and
reimplementing them inder arch/foo, inventing wheels (sometimes
square) and generally being not up to date.

-- Pete
