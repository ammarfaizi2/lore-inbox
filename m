Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWIVUIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWIVUIm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 16:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWIVUIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 16:08:42 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:19853 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S964835AbWIVUIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 16:08:40 -0400
X-IronPort-AV: i="4.09,204,1157353200"; 
   d="scan'208"; a="324400801:sNHT34277862"
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, davidsen@tmr.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org>
	<45130533.2010209@tmr.com> <45130527.1000302@garzik.org>
	<20060921.145208.26283973.davem@davemloft.net>
	<20060921220539.GL26683@redhat.com>
	<20060922083542.GA4246@flint.arm.linux.org.uk>
	<20060922154816.GA15032@redhat.com>
	<Pine.LNX.4.64.0609220901040.4388@g5.osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 22 Sep 2006 13:08:37 -0700
In-Reply-To: <Pine.LNX.4.64.0609220901040.4388@g5.osdl.org> (Linus Torvalds's message of "Fri, 22 Sep 2006 09:21:32 -0700 (PDT)")
Message-ID: <aday7sbfyuy.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 22 Sep 2006 20:08:38.0943 (UTC) FILETIME=[E49FCAF0:01C6DE82]
Authentication-Results: sj-dkim-5.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Linus>   And then at some point (probably later today) I decide to
    Linus> go into "merge mode" and go back to old mails I ignored and
    Linus> start applying them and pulling from other peoples git
    Linus> trees. And so if my "mode switching" has a longer latency
    Linus> than the "please pull" frequency, I end up seeing two
    Linus> requests for the same tree during the same "merge mode"
    Linus> thing, which just means that when I look at the older one,
    Linus> it no longer matches what is in the tree I'm pulling from.

My way of handling this has been to wait until you've acted on my
first merge request before sending another one.  I also don't touch my
published "for-linus" branch in git until you've pulled it.  I just
batch up pending changes in my "for-2.6.19" branch until my next merge
(and I also encourage people interested in Infiniband to run my
for-2.6.19 branch)

If I do see you merging other trees (in "merge mode") and skipping my
merge requests, I'll send a gentle reminder of my first merge request.

 - R.
