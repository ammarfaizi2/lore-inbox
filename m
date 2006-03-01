Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWCASdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWCASdi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 13:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWCASdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 13:33:38 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:59864 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750990AbWCASdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 13:33:37 -0500
Date: Wed, 1 Mar 2006 10:33:32 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: task_mmu bug fix.
Message-Id: <20060301103332.9131139f.pj@sgi.com>
In-Reply-To: <20060228234628.55ee9f76.akpm@osdl.org>
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
	<20060228181849.faaf234e.pj@sgi.com>
	<20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
	<m1u0aiocc1.fsf_-_@ebiederm.dsl.xmission.com>
	<20060228234628.55ee9f76.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Thanks.  Do you think this is likely to fix the crashes reported by
> Laurent, Jesper, Paul, Rafael and Martin?

I presume it was getting the 'fuser ...' crash,
since Eric was using the same command I was using.

I need to run Eric's fix with my SGI inhouse
application that I first saw this on, to be sure
it's happy too.

I'm optimistic that will work too.  Hopefully
I can get to this sometime this evening.

The gregkh/sysfs/... boot failure is a separate
bug, as I trust you are aware from your responses
on that failure.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
