Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbTEVAeP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 20:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbTEVAeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 20:34:15 -0400
Received: from dp.samba.org ([66.70.73.150]:47760 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262412AbTEVAeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 20:34:12 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3 
In-reply-to: Your message of "Wed, 21 May 2003 11:48:49 +0200."
             <Pine.LNX.4.44.0305211140120.2045-100000@localhost.localdomain> 
Date: Thu, 22 May 2003 10:30:54 +1000
Message-Id: <20030522004714.C3A2F2C0A7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0305211140120.2045-100000@localhost.localdomain> you 
write:
> 
> On Wed, 21 May 2003, Rusty Russell wrote:
> 
> > Perhaps I was reading too much into Linus' mail, but I read it as "don't
> > obsolete the old interface and introduce a new one just because of some
> > sense of aesthetics".
> 
> no. The concept is: "dont cause the user any pain". Reshuffling the
> syscall internally and providing new interfaces for the feature to be
> exposed in a cleaner way is perfectly OK as long as this does not hurt
> anything else

I understand what you're saying, but I disagree.

See, I don't think the current interface is too ugly to live.
Especially since you don't need to introduce a new arg to implement
FUTEX_REQUEUE, so there's no immediate problem with it.

Do you understand what I'm saying?  If so, we can agree to disagree,
and it doesn't matter, because Linus will take your patch 8)

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
