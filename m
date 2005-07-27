Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVG0Oq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVG0Oq7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 10:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVG0Oq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 10:46:58 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:39661 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262096AbVG0Oq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 10:46:56 -0400
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050727143843.GB26303@elte.hu>
References: <1122473595.29823.60.camel@localhost.localdomain>
	 <20050727141754.GA25356@elte.hu>
	 <1122474539.29823.68.camel@localhost.localdomain>
	 <20050727143843.GB26303@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 27 Jul 2005 10:46:31 -0400
Message-Id: <1122475591.29823.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 16:38 +0200, Ingo Molnar wrote:

> a fair number of apps assume that there's _at least_ 100 levels of 
> priorities. The moment you have a custom kernel that offers more than 
> 100 priorities, there will be apps that assume that there are more than 
> 100 priority levels, and will break if there are less.

That's not the same. The apps on my computer right now should not assume
that I have 100 priorities.  Since I'm free to work with any kernel that
I want.  The customers that ask for a custom kernel are also writing
custom apps for a specific product.  Things can be assumed more since
the apps are not generic tools that are running on desktops.  In fact,
some of these apps require special hardware to work (at least a driver
to imitate the hardware).

-- Steve


