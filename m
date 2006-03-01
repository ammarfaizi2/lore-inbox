Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932602AbWCAHri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbWCAHri (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 02:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbWCAHri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 02:47:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60090 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932602AbWCAHri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 02:47:38 -0500
Date: Tue, 28 Feb 2006 23:46:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org, pj@sgi.com
Subject: Re: [PATCH] proc: task_mmu bug fix.
Message-Id: <20060228234628.55ee9f76.akpm@osdl.org>
In-Reply-To: <m1u0aiocc1.fsf_-_@ebiederm.dsl.xmission.com>
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
	<20060228181849.faaf234e.pj@sgi.com>
	<20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
	<m1u0aiocc1.fsf_-_@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> This should fix the big bug that has been crashing kernels when
>  fuser is called.  At least it is the bug I observed here.  It seems
>  you need the right access pattern on /proc/<pid>/maps to trigger this.

Thanks.  Do you think this is likely to fix the crashes reported by
Laurent, Jesper, Paul, Rafael and Martin?
