Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030478AbVIJCvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbVIJCvT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 22:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVIJCvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 22:51:19 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:1958 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932601AbVIJCvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 22:51:18 -0400
Date: Fri, 9 Sep 2005 19:31:00 -0700
From: Paul Jackson <pj@sgi.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: stable@kernel.org, chrisw@osdl.org, akpm@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 2.6.13-stable] cpuset semaphore double trip fix
Message-Id: <20050909193100.068c6b22.pj@sgi.com>
In-Reply-To: <20050909185605.0f8e53e6.rdunlap@xenotime.net>
References: <20050910004403.29717.51121.sendpatchset@jackhammer.engr.sgi.com>
	<20050909185605.0f8e53e6.rdunlap@xenotime.net>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Documentation/stable_kernel_rules.txt 

Aha - that's the stable documentation that I missed.  Thanks, Randy.

I figured that there was an explanation somewhere.  And there it is,
right in plain view.

Reading ...

My patch does pass the following criteria:

 - No "theoretical race condition" issues, unless an explanation of how
   the race can be exploited.

The conditions to trigger the race are too delicate to exploit
quickly.  I don't have a coded exploit.

Apparently I did the right thing by _not_ sending this patch to
stable@kernel.org <grin>.

This patch is dead.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
