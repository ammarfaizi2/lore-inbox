Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751902AbWCAU6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbWCAU6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbWCAU6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:58:12 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60317 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751902AbWCAU6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:58:11 -0500
Date: Wed, 1 Mar 2006 12:58:02 -0800
From: Paul Jackson <pj@sgi.com>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060301125802.cce9ef51.pj@sgi.com>
In-Reply-To: <20060301192103.GA14320@kroah.com>
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
	<20060228181849.faaf234e.pj@sgi.com>
	<20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
	<20060228234807.55f1b25f.pj@sgi.com>
	<20060301002631.48e3800e.akpm@osdl.org>
	<20060301015338.b296b7ad.pj@sgi.com>
	<20060301192103.GA14320@kroah.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg wrote:
> As reported this is expected, and can be ignored safely.  It's just scsi
> being bad :)

Yeah - so I eventually realized.

> >  [<a0000001001eac90>] sysfs_create_group+0x30/0x2a0
> >                                 sp=e00002343bd97d50 bsp=e00002343bd91120
> >  [<a000000100809190>] topology_cpu_callback+0x70/0xc0
> >                                 sp=e00002343bd97d60 bsp=e00002343bd910f0
> >  [<a000000100809260>] topology_sysfs_init+0x80/0x120
> >                                 sp=e00002343bd97d60 bsp=e00002343bd910d0
> 
> This points at the sysfs cpu patches that are in -mm, which are not in
> my tree...

So ... what does that mean for who should be looking at this?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
