Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWJRXRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWJRXRs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 19:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWJRXRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 19:17:48 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:64434 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751537AbWJRXRr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 19:17:47 -0400
Subject: Re: 2.6.18 w/ GPS time source: worse performance
From: john stultz <johnstul@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Valdis.Kletnieks@vt.edu, Udo van den Heuvel <udovdh@xs4all.nl>,
       linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1161207996.15860.134.camel@mindpipe>
References: <4534F5F7.8020003@xs4all.nl> <1161103616.2919.70.camel@mindpipe>
	 <45364631.9070805@xs4all.nl> <1161189384.15860.85.camel@mindpipe>
	 <45365A0B.5030306@xs4all.nl>
	 <200610181957.k9IJvw4m013149@turing-police.cc.vt.edu>
	 <1161207996.15860.134.camel@mindpipe>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 16:17:39 -0700
Message-Id: <1161213459.5875.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 17:46 -0400, Lee Revell wrote:
> [added John Stultz to cc]
> 
> On Wed, 2006-10-18 at 15:57 -0400, Valdis.Kletnieks@vt.edu wrote:
> > On Wed, 18 Oct 2006 18:44:59 +0200, Udo van den Heuvel said:
> > > 
> > > It is stuff that is visible by watching ntpq -pn output, by letting mrtg
> > > graph stuff, etc. Watch the offset and jitter collumns.
> > > Check /usr/sbin/ntpdc -c kerninfo output. Graph that stuff.
> > 
> > So... you've presumably done that while identifying there is an issue.
> > Please share the results.  Have you tried booting back into a 2.6.17
> > or so and seen offset/jitter improve?  etc etc etc.

Udo: 
	Are you running the linuxpps patches, or is this vanilla 2.6.18 without
any additional patches? Mind sending your dmesg and some "ntpdc -c
kerninfo" output? Any of those graphs you mention above would be great
as well.

thanks
-john


