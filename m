Return-Path: <linux-kernel-owner+w=401wt.eu-S936479AbWLIJE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936479AbWLIJE0 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 04:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936477AbWLIJE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 04:04:26 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34812 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936473AbWLIJEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 04:04:25 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, ebiederm@xmission.com,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH] ipc-procfs-sysctl mixups
References: <20061209003801.1df115b6.randy.dunlap@oracle.com>
Date: Sat, 09 Dec 2006 02:04:05 -0700
In-Reply-To: <20061209003801.1df115b6.randy.dunlap@oracle.com> (Randy Dunlap's
	message of "Sat, 9 Dec 2006 00:38:01 -0800")
Message-ID: <m18xhhzbi2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <randy.dunlap@oracle.com> writes:

> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> When CONFIG_PROC_FS=n and CONFIG_PROC_SYSCTL=n but CONFIG_SYSVIPC=y,
> we get this build error:
>
> kernel/built-in.o:(.data+0xc38): undefined reference to
> `proc_ipc_doulongvec_minmax'
> kernel/built-in.o:(.data+0xc88): undefined reference to
> `proc_ipc_doulongvec_minmax'
> kernel/built-in.o:(.data+0xcd8): undefined reference to `proc_ipc_dointvec'
> kernel/built-in.o:(.data+0xd28): undefined reference to `proc_ipc_dointvec'
> kernel/built-in.o:(.data+0xd78): undefined reference to `proc_ipc_dointvec'
> kernel/built-in.o:(.data+0xdc8): undefined reference to `proc_ipc_dointvec'
> kernel/built-in.o:(.data+0xe18): undefined reference to `proc_ipc_dointvec'
> make: *** [vmlinux] Error 1
>
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

Acked-by: Eric Biederman <ebiederm@xmission.com>

Oops.  Thanks for catching this.

Eric
