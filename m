Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266485AbUIMJk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUIMJk0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 05:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266487AbUIMJk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 05:40:26 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:55951 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266485AbUIMJkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 05:40:25 -0400
Date: Mon, 13 Sep 2004 02:39:19 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: derrs@openx3.frec.bull.fr, simon.derr@bull.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpusets: alternative fix for possible race in
 cpuset_tasks_read()
Message-Id: <20040913023919.62eb772c.pj@sgi.com>
In-Reply-To: <20040913022524.6d3b711e.pj@sgi.com>
References: <Pine.LNX.4.58.0409101632100.2891@daphne.frec.bull.fr>
	<20040911010120.572595e3.pj@sgi.com>
	<Pine.LNX.4.61.0409131012010.18437@openx3.frec.bull.fr>
	<20040913022524.6d3b711e.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aha - Andrew beat me to the mm5 draw.

I will send this patch again, shortly, against mm5, reversing the
affects of:

  cpusets-fix-possible-race-in-cpuset_tasks_read.patch

and applying this alternative instead.

==> Ignore the patch I sent 15 minutes ago, with
    Message-Id: <20040913022524.6d3b711e.pj@sgi.com>

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
