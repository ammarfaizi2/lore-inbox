Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030404AbVIJDlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbVIJDlE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 23:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbVIJDlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 23:41:03 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:23742 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030404AbVIJDlC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 23:41:02 -0400
Date: Fri, 9 Sep 2005 20:40:54 -0700
From: Paul Jackson <pj@sgi.com>
To: Chris Wright <chrisw@osdl.org>
Cc: chrisw@osdl.org, akpm@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, stable@kernel.org
Subject: Re: [PATCH 2.6.13-stable] cpuset semaphore double trip fix
Message-Id: <20050909204054.1ba43ebd.pj@sgi.com>
In-Reply-To: <20050910032844.GH7762@shell0.pdx.osdl.net>
References: <20050910004403.29717.51121.sendpatchset@jackhammer.engr.sgi.com>
	<20050910030127.GE7762@shell0.pdx.osdl.net>
	<20050909202030.541049a7.pj@sgi.com>
	<20050910032844.GH7762@shell0.pdx.osdl.net>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris wrote:
> OK, we can hold until you find a good case for triggering ;-)

Agreed.

By the way, you or Randy mentioned something about leaving a mention of
-stable in the MAINTAINERS file.

That wouldn't have helped me this week, but if you had put the string:

	Documentation/stable_kernel_rules.txt

somewhere in the opening text of the messages that announce stable
reviews, that would have saved me some time.  I have in mind the
lkml messages such as:

	From: Chris Wright <chrisw@osdl.org>
	To: linux-kernel@vger.kernel.org, stable@kernel.org
	Subject: [PATCH 0/9] -stable review
	
	This is the start of the stable review cycle for the 2.6.13.1 release.

Just a thought ...

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
