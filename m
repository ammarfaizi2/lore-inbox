Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263423AbTDDGh1 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 01:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263425AbTDDGh1 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 01:37:27 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:47048 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263423AbTDDGhU (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 01:37:20 -0500
Date: Fri, 4 Apr 2003 01:48:44 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch for show_task
Message-ID: <20030404014844.B30163@devserv.devel.redhat.com>
References: <20030404013829.A30163@devserv.devel.redhat.com> <20030403224346.51d9680e.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030403224346.51d9680e.akpm@digeo.com>; from akpm@digeo.com on Thu, Apr 03, 2003 at 10:43:46PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 3 Apr 2003 22:43:46 -0800
> From: Andrew Morton <akpm@digeo.com>

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.66/2.5.66-mm3/broken-out/show_task-free-stack-fix.patch

I see. What do you say to adding thread_saved_sp() in addition
to thread_saved_pc()? E.g. on sparc that would return
p->thread_info->ti_ksp, then you can calculate free stack.

-- Pete
