Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264042AbUDGSGG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 14:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264079AbUDGSGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 14:06:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:225 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264042AbUDGSGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 14:06:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16500.17103.665134.7465@neuro.alephnull.com>
Date: Wed, 7 Apr 2004 14:05:03 -0400
From: Rik Faith <faith@redhat.com>
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, rusty@au1.ibm.com
Subject: Re: [RFC] [PATCH] Improve list.h documentation for _rcu() primitives
In-Reply-To: [Paul E. McKenney <paulmck@us.ibm.com>] Mon  5 Apr 2004 14:55:25 -0700
References: <20040405215524.GA2173@us.ibm.com>
X-Key: 7EB57214; 958B 394D AD29 257E 553F  E7C7 9F67 4BE0 7EB5 7214
X-Url: http://www.redhat.com/
X-Mailer: VM 7.17; XEmacs 21.4; Linux 2.4.22-1.2163.nptl (neuro)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon  5 Apr 2004 14:55:25 -0700,
   Paul E. McKenney <paulmck@us.ibm.com> wrote:
> The attached patch improves the documentation of the _rcu list
> primitives, as suggested off-list.
> 
> 						Thanx, Paul

Thanks for making these changes!

I recently used the _rcu list primitives for the audit framework and I
found that, even though I read the header file comments and the papers
that were referenced, and even though I then had a good understanding of
RCU, I missed some implementation details about how the primitives
themselves should be used inside the Linux kernel.

These new comments fill in those missing details -- I hope they are
accepted into the kernel.

