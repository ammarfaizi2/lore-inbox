Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWDJELu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWDJELu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 00:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWDJELu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 00:11:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5780 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750953AbWDJELt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 00:11:49 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] coredump: speedup SIGKILL sending
In-Reply-To: Oleg Nesterov's message of  Friday, 7 April 2006 02:06:28 +0400 <20060406220628.GA237@oleg>
X-Windows: the first fully modular software disaster.
Message-Id: <20060410041139.D64A61809D1@magilla.sf.frob.com>
Date: Sun,  9 Apr 2006 21:11:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With this patch a thread group is killed atomically under ->siglock.
> This is faster because we can use sigaddset() instead of force_sig_info()
> and this is used in further patches.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Looks good to me.

Signed-off-by: Roland McGrath <roland@redhat.com>


Thanks,
Roland
