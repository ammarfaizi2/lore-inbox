Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbVINU0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbVINU0Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbVINU0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:26:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12936 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932545AbVINU0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:26:23 -0400
Date: Wed, 14 Sep 2005 13:24:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: lserinol@gmail.com
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org, jlan@engr.sgi.com,
       lse-tech@lists.sourceforge.net,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       kaigai@ak.jp.nec.com, elsa-devel@lists.sourceforge.net
Subject: Re: [PATCH] per process I/O statistics for userspace
Message-Id: <20050914132437.7c32b739.akpm@osdl.org>
In-Reply-To: <2c1942a705091413171e63bf55@mail.gmail.com>
References: <2c1942a7050912052759c7f730@mail.gmail.com>
	<20050914092338.GA2260@elf.ucw.cz>
	<2c1942a705091413171e63bf55@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Levent Serinol <lserinol@gmail.com> wrote:
>
> +int proc_pid_iostat(struct task_struct *task, char *buffer)
>  +{
>  +       return sprintf(buffer,"%llu %llu\n",task->rchar,task->wchar);
>  +}

Those fields have been sitting there unused for months.  I'd like to hear
what the system accounting guys are intending to do with them before
proceeding, please.
