Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265466AbTFMSCH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 14:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265468AbTFMSCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 14:02:06 -0400
Received: from ip68-107-142-198.tc.ph.cox.net ([68.107.142.198]:12180 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP id S265466AbTFMSBi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 14:01:38 -0400
Date: Fri, 13 Jun 2003 11:15:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Robert Love <rml@tech9.net>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Bernd Eckenfels <ecki-lkm@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make gcc3.3 Eliminate Unused Static Functions
Message-ID: <20030613181516.GT828@ip68-0-152-218.tc.ph.cox.net>
References: <E19Qeoz-0004CM-00@calista.inka.de> <3EE9DA08.2020707@nortelnetworks.com> <20030613160335.GO828@ip68-0-152-218.tc.ph.cox.net> <1055527639.662.364.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055527639.662.364.camel@localhost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 11:07:19AM -0700, Robert Love wrote:
> On Fri, 2003-06-13 at 09:03, Tom Rini wrote:
> 
> > ... only if we say a min gcc version of 3.3 however, yes?  Otherwise the
> > kernel gets rather bloated.  Just how wide-spread (and Good To Use) is
> > gcc-3.3 now?
> 
> Good point.
> 
> I have been using gcc-3.3 for awhile now with success, and I can
> recommend it at least for x86, but that really is not reason to force
> anyone to move to it (yet).

But how much have you rebuilt, heavily tested, etc?  I know that
currently Debian/sid is building XFree86 4.1 at -O on all arches due to
gcc-3.3 issues (some xdm auth problem on ppc and x86, other things
elsewhere).

> So this change will be nice when gcc 3.3 or greater is the minimum
> compiler, but not very nice until then. If we start eradicating ifdefs
> users of older compilers will get very bloated kernels.

Indeed.

-- 
Tom Rini
http://gate.crashing.org/~trini/
