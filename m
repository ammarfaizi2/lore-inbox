Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWCAIjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWCAIjV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 03:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbWCAIjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 03:39:21 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:53926 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932279AbWCAIjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 03:39:20 -0500
Date: Wed, 1 Mar 2006 00:39:17 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060301003917.205ec5a3.pj@sgi.com>
In-Reply-To: <20060301002631.48e3800e.akpm@osdl.org>
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
	<20060228181849.faaf234e.pj@sgi.com>
	<20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
	<20060228234807.55f1b25f.pj@sgi.com>
	<20060301002631.48e3800e.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Did that machine run rc4-mm2?

It's twin sister ran rc4-mm2, as that is where I
tested the last "cpuset memory spread slab file i/o"
patch I sent you.

> That would point at either the sysfs changes in gregkh-driver-* or acpi. 
> There have been no changes in the acpi patch in a couple of weeks. 

I'll give these gregkh changes a higher weighting in my
"biased binary search".  Thanks.

I've got time now to do a few more slices.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
