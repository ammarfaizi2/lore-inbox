Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269024AbUIHDiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269024AbUIHDiE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 23:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269026AbUIHDiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 23:38:03 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:61389 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269024AbUIHDhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 23:37:53 -0400
Subject: Re: [CHECKER] possible deadlock in 2.6.8.1 lockd code
From: Greg Banks <gnb@melbourne.sgi.com>
To: Dawson Engler <engler@coverity.dreamhost.com>
Cc: linux-kernel@vger.kernel.org, developers@coverity.com
In-Reply-To: <Pine.LNX.4.58.0409071956380.6778@coverity.dreamhost.com>
References: <Pine.LNX.4.58.0409071956380.6778@coverity.dreamhost.com>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1094615146.20243.162.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 08 Sep 2004 13:45:46 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-08 at 12:57, Dawson Engler wrote:
> Hi All,
> 
> below is a possible deadlock in the linux-2.6.8.1 lockd code found by a
> static deadlock checker I'm writing.  Let me know if it looks valid and/or
> whether the output is too cryptic.  (Note, the locking dependencies go
> across a bunch of function calls, so the paths may be infeasible.)

Nick's comment applies here.  Furthermore, there is at most one lockd
thread so once again there is no thread B to deadlock with.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


