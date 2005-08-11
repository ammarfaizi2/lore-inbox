Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbVHKCoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVHKCoH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 22:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVHKCoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 22:44:07 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:45957 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932231AbVHKCoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 22:44:06 -0400
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
From: Lee Revell <rlrevell@joe-job.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <1123727994.32531.62.camel@cog.beaverton.ibm.com>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123726394.32531.33.camel@cog.beaverton.ibm.com>
	 <1123727560.30850.1.camel@mindpipe>
	 <1123727994.32531.62.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 22:44:04 -0400
Message-Id: <1123728244.30850.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-10 at 19:39 -0700, john stultz wrote:
> Ah, I've got a patch on my laptop that takes that down to ~2% or less.
> I didn't include it in this patch set but I'll work to get it
> integrated before the next release. Sorry about that.
> 
> If you have any suggestions for further performance improvements,
> please let me know.

2% sounds reasonable to me.  I just don't think we can afford 20%
because so many stupid apps bang on gettimeofday() constantly.

Lee

