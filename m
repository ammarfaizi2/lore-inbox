Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWCAKLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWCAKLP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 05:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWCAKLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 05:11:15 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:1458 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932172AbWCAKLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 05:11:14 -0500
Date: Wed, 1 Mar 2006 02:11:06 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060301021106.4e2359eb.pj@sgi.com>
In-Reply-To: <20060301015338.b296b7ad.pj@sgi.com>
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
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drat - off by one in my reporting again.  The first "good" (1) case
was one patch earlier than reported above.

cpufreq-_ppc-frequency-change-issues-freq-already-lowered-by-bios.patch - good
gregkh-driver-put_device-might_sleep.patch                              - untested
gregkh-driver-empty_release_functions_are_broken.patch                  - special case
gregkh-driver-allow-sysfs-attribute-files-to-be-pollable.patch          - bad

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
