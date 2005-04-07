Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262583AbVDGURR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbVDGURR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 16:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262586AbVDGURR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 16:17:17 -0400
Received: from zxa8020.lanisdn-gte.net ([206.46.31.146]:5075 "EHLO
	links.magenta.com") by vger.kernel.org with ESMTP id S262583AbVDGURN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 16:17:13 -0400
Date: Thu, 7 Apr 2005 16:16:58 -0400
From: Raul Miller <moth@debian.org>
To: linux-kernel@vger.kernel.org, debian-legal@lists.debian.org,
       linux-acenic@sunsite.dk
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050407161658.S32136@links.magenta.com>
References: <yq08y3vxd3x.fsf@jaguar.mkp.net> <MDEHLPKNGKAHNMBLJOLKAEKLCPAB.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAEKLCPAB.davids@webmaster.com>; from davids@webmaster.com on Thu, Apr 07, 2005 at 01:26:17AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 01:26:17AM -0700, David Schwartz wrote:
> If you believe the linker "merely aggregates" the object code for the
> driver with the data for the firmware, I can't see how you can argue
> that any linking is anything but mere aggregation. In neither case can
> you separate the linked work into the two separate works and in both
> cases the linker provides one work direct access to the other.

You can indeed separate the firmware and the kernel into two separate
works.  That's what people have been proposing as the solution to this
problem.

Also, "mere aggregation" is a term from the GPL.  You can read what
it says there yourself.  But basically it's there so that people make
a distinction between the program itself and other stuff that isn't
the program.

Without that mere aggregation clause, people might be claiming that
text on a disk has to be GPLed because of emacs, or that postscript
files have to be GPLed because of ghostscript, or more generally that
arbitrary object FOO has to be GPLed because of gpled program BAR.

Put another way, what the linker does or doesn't do isn't really the
issue.

People like to think that the linker is somehow special for copyright,
but it's not.  Either the stuff being linked is protected by copyright
even when it's not linked or it's not protected by copyright after it is
linked.  If the license says something about linking then that matters,
but only for cases where the code was protected by copyright even before
it was linked.  And then linking only matters in the specific way that
that license says it matters.

-- 
Raul
