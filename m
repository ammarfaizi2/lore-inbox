Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWDGKdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWDGKdt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 06:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWDGKdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 06:33:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50132 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751336AbWDGKds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 06:33:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix do_coredump() vs SIGSTOP race
In-Reply-To: Oleg Nesterov's message of  Friday, 7 October 2005 17:46:19 +0400 <43467C2B.14D992B4@tv-sign.ru>
X-Windows: power tools for power fools.
Message-Id: <20060407103344.8C6CF1809D1@magilla.sf.frob.com>
Date: Fri,  7 Apr 2006 03:33:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I have been absent from the discussion for such a long time.
I'm trying to catch up on old issues that I should have reviewed earlier.

I like this change.  I think it's sensible to keep the invariant that
SIGNAL_STOP_DEQUEUED can't be set when SIGNAL_GROUP_EXIT is set.
Good work, Oleg.


Thanks,
Roland
