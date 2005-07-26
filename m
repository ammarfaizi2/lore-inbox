Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVGZOev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVGZOev (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 10:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVGZOev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 10:34:51 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:54677 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261789AbVGZOeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 10:34:50 -0400
Subject: Re: [PATCH] 2.6.13rc3: RLIMIT_RTPRIO broken
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Andreas Steinmetz <ast@domdv.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20050726120617.GA12338@elte.hu>
References: <42E22D0C.1010608@domdv.de> <20050726102638.GA4000@elte.hu>
	 <4d8e3fd305072604562c8b30d1@mail.gmail.com>
	 <20050726120617.GA12338@elte.hu>
Content-Type: text/plain
Date: Tue, 26 Jul 2005 10:34:47 -0400
Message-Id: <1122388488.18884.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-26 at 14:06 +0200, Ingo Molnar wrote:
> i'd not put it into stable just yet - the fact that it has not been 
> tested in 2.6.12 _at all_ up until very recently means there's little
> QA feedback. Yes, it's simple, but it also triggers something we never
> did before. 2.6.13 ought to be released soon, that should be good
> enough.

Also, no distro is shipping the updated PAM, glibc, and bash packages
needed to use the new feature yet, even in their development releases.
So there would be very little point in putting this in -stable.

Lee

