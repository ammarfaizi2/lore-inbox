Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268338AbTANDNv>; Mon, 13 Jan 2003 22:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268551AbTANDMu>; Mon, 13 Jan 2003 22:12:50 -0500
Received: from dp.samba.org ([66.70.73.150]:19363 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268548AbTANDMq>;
	Mon, 13 Jan 2003 22:12:46 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org, davem@vger.kernel.org
Subject: Re: [module-init-tools] fix weak symbol handling 
In-reply-to: Your message of "Mon, 13 Jan 2003 11:04:57 -0800."
             <20030113110457.A936@twiddle.net> 
Date: Tue, 14 Jan 2003 14:16:57 +1100
Message-Id: <20030114032138.7B1482C40D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030113110457.A936@twiddle.net> you write:
> The pair to the kernel patch posted a moment ago.

So the semantics you want are that if A declares a weak symbol S, and
B exports a (presumably non-weak) symbol S, then A depends on B?

I think that's right, given that that is what would happen if A and B
were builtin.

Now, what does Dave think about using weak symbols?  Or is this
Alpha-specific?

Applied,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
