Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWDJIFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWDJIFm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 04:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWDJIFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 04:05:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48784 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751017AbWDJIFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 04:05:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] coredump: don't take tasklist_lock
In-Reply-To: Oleg Nesterov's message of  Friday, 7 April 2006 02:06:36 +0400 <20060406220635.GA243@oleg>
X-Antipastobozoticataclysm: Bariumenemanilow
Message-Id: <20060410080525.9C3661809D1@magilla.sf.frob.com>
Date: Mon, 10 Apr 2006 01:05:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch removes tasklist_lock from zap_threads().

That's a very worthwhile thing to do, and this change looks good to me.
I have not 100% followed the recent related de_thread discussion, but
certainly issues there should be resolved such that this change can be done.


Thanks,
Roland
