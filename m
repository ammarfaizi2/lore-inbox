Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269700AbTGJXWk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269702AbTGJXWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:22:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:12015 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S269700AbTGJXVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:21:54 -0400
Subject: Re: Linux 2.5.75
From: Robert Love <rml@tech9.net>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1057879835.584.7.camel@teapot.felipe-alfaro.com>
References: <Pine.LNX.4.44.0307101405490.4560-100000@home.osdl.org>
	 <1057879835.584.7.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Message-Id: <1057880428.1984.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 10 Jul 2003 16:40:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-10 at 16:30, Felipe Alfaro Solana wrote:

> I'm worried about the current status of the 2.5 kernel scheduler.

I am sure Linus and Andrew will continue to take patches to tune the
scheduler, as long as they are clearly tuning issues.

I do not see it as a _huge_ problem, because we are just worrying about
corner cases now. Worst case we can turn off the interactivity estimator
- which is both the root of the improvement and the problems - and be
back to where we are in 2.4.

	Robert Love


