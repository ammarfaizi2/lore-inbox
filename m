Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWCAFGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWCAFGh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 00:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWCAFGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 00:06:37 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14054 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932290AbWCAFGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 00:06:36 -0500
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
	<20060228181849.faaf234e.pj@sgi.com>
	<20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 28 Feb 2006 22:05:18 -0700
In-Reply-To: <20060228201040.34a1e8f5.pj@sgi.com> (Paul Jackson's message of
 "Tue, 28 Feb 2006 20:10:40 -0800")
Message-ID: <m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

> With these three patches:
>     proc-dont-lock-task_structs-indefinitely.patch
>     proc-dont-lock-task_structs-indefinitely-git-nfs-fix.patch
>     proc-dont-lock-task_structs-indefinitely-cpuset-fix.patch
>
> the command:
>
>     /bin/fuser -n tcp 5553

I can kill a kernel this way as well.  Thanks this looks like
a good reproducer I will see if  I can figure out why.

Eric
