Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423035AbWJRVqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423035AbWJRVqb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423032AbWJRVqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:46:30 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:13252 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1423035AbWJRVqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:46:30 -0400
Subject: Re: 2.6.18 w/ GPS time source: worse performance
From: Lee Revell <rlrevell@joe-job.com>
To: Valdis.Kletnieks@vt.edu
Cc: Udo van den Heuvel <udovdh@xs4all.nl>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <200610181957.k9IJvw4m013149@turing-police.cc.vt.edu>
References: <4534F5F7.8020003@xs4all.nl> <1161103616.2919.70.camel@mindpipe>
	 <45364631.9070805@xs4all.nl> <1161189384.15860.85.camel@mindpipe>
	 <45365A0B.5030306@xs4all.nl>
	 <200610181957.k9IJvw4m013149@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 17:46:35 -0400
Message-Id: <1161207996.15860.134.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[added John Stultz to cc]

On Wed, 2006-10-18 at 15:57 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 18 Oct 2006 18:44:59 +0200, Udo van den Heuvel said:
> > 
> > It is stuff that is visible by watching ntpq -pn output, by letting mrtg
> > graph stuff, etc. Watch the offset and jitter collumns.
> > Check /usr/sbin/ntpdc -c kerninfo output. Graph that stuff.
> 
> So... you've presumably done that while identifying there is an issue.
> Please share the results.  Have you tried booting back into a 2.6.17
> or so and seen offset/jitter improve?  etc etc etc.

Udo,

My crystal ball says this is related to the clocksource changes.  But at
the very least dmesg and kernel .config is required for debugging.

Also, don't trim CC lists - always use Reply-To-All for LKML threads.

Lee

