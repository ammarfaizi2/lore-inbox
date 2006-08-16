Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWHPFxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWHPFxx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 01:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWHPFxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 01:53:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:37818 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750899AbWHPFxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 01:53:52 -0400
Date: Tue, 15 Aug 2006 22:53:32 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: suresh.b.siddha@intel.com, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, mingo@redhat.com, apw@shadowen.org
Subject: Re: [patch] sched: group CPU power setup cleanup
Message-Id: <20060815225332.a0192fbb.pj@sgi.com>
In-Reply-To: <20060815214718.00814767.akpm@osdl.org>
References: <20060815175525.A2333@unix-os.sc.intel.com>
	<20060815212455.c9fe1e34.pj@sgi.com>
	<20060815214718.00814767.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Believe it or not, I usually suffer in silence.

I do too (though I look at 0.001% of the patches you do ;).

This time, I was motivated to actually figure this code out a bit,
as a common way to get to this code is via a cpuset cpu_exclusive
setting, and of late a couple of bugs in earlier versions of this
code had caused me grief.

So I was hoping for more useful patch changelog comments, in my
quest to rise above my newbie ranking in kernel/sched.c code.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
