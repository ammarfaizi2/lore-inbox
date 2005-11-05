Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbVKEHnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbVKEHnK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 02:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVKEHnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 02:43:10 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:22221 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751361AbVKEHnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 02:43:09 -0500
Date: Fri, 4 Nov 2005 23:43:00 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon.Derr@bull.net, ak@suse.de, linux-kernel@vger.kernel.org,
       clameter@sgi.com
Subject: Re: [PATCH 5/5] cpuset: memory reclaim rate meter
Message-Id: <20051104234300.7e531ac2.pj@sgi.com>
In-Reply-To: <20051104231320.6c4525a8.akpm@osdl.org>
References: <20051104053109.549.76824.sendpatchset@jackhammer.engr.sgi.com>
	<20051104053153.549.83350.sendpatchset@jackhammer.engr.sgi.com>
	<20051104231320.6c4525a8.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I guess I'll give up and merge this thing.

Actually - definitely wait for the next version.

Kill the version you have of this patch.

I just realized that "memory_reclaim_rate" was a bogus
name for this feature.  The users, batch managers, don't
give a dang that its hooked into some direct reclaim
point in the kernel.

They just want a decent measure of memory pressure in
a cpuset.

So I am going to rename the flag, to "memory_pressure".

Kill the current 'memory reclaim rate' patch.  I will
resend in perhaps an hour, under this new name.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
