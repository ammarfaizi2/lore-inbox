Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbVG0OcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVG0OcD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 10:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVG0O3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 10:29:23 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:64419 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262287AbVG0O3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 10:29:11 -0400
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050727141754.GA25356@elte.hu>
References: <1122473595.29823.60.camel@localhost.localdomain>
	 <20050727141754.GA25356@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 27 Jul 2005 10:28:59 -0400
Message-Id: <1122474539.29823.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 16:17 +0200, Ingo Molnar wrote:
> i'd not do this patch, mainly because the '100 priority levels' thing is 
> pretty much an assumption in lots of userspace code. 

I must argue though, any user app that assumes 100 is the max prio is
already broken.  That's why there are system calls to get the actual
range.  Maybe it would be good to change the range to find the apps that
break. And then fix them.

-- Steve


