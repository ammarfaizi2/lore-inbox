Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264595AbUD1B6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264595AbUD1B6k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 21:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264596AbUD1B6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 21:58:39 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:21216 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S264595AbUD1B6g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 21:58:36 -0400
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
From: Rusty Russell <rusty@rustcorp.com.au>
To: Marc Boucher <marc@linuxant.com>
Cc: pmarques@grupopie.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       malda@slashdot.org, c-d.hailfinger.kernel.2004@gmx.net,
       Linus Torvalds <torvalds@osdl.org>, jon787@tesla.resnet.mtu.edu
In-Reply-To: <47B669B0-98A7-11D8-85DF-000A95BCAC26@linuxant.com>
References: <20040427165819.GA23961@valve.mbsi.ca>
	 <1083107550.30985.122.camel@bach>
	 <47B669B0-98A7-11D8-85DF-000A95BCAC26@linuxant.com>
Content-Type: text/plain
Message-Id: <1083117450.2152.222.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Apr 2004 11:57:30 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-28 at 10:02, Marc Boucher wrote:
>  In other cases, we have gladly submitted patches when we 
> encountered bugs and
> could fix them. Had we known that the module fix was so simple, it 
> would of course have been
> submitted it to you in parallel.

Let me spell it out.

You deceived users by circumventing a check designed to tell them that
their kernel was tainted.  You deceived maintainers who receive
"untainted" bug reports.  In a way, you lied directly to the kernel
community: the module code is our agent in checking module licenses.

That you've been doing it for a while, or that you didn't spend
significant time investigating alternatives or talking to the maintainer
about your problem only compounds the damage.  That I know and like you
only heightens my disappointment.

Hence I stand by my original comment:

	This shows a lack of integrity that I find personally repulsive.

Hope that clarifies,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

