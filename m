Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWHIGnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWHIGnc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 02:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWHIGnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 02:43:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25271 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964890AbWHIGnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 02:43:31 -0400
Date: Tue, 8 Aug 2006 23:43:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jay Lan <jlan@sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Jes Sorensen <jes@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Tony Ernst <tee@sgi.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: [PATCH] csa accounting taskstats update
Message-Id: <20060808234321.dbff4c37.akpm@osdl.org>
In-Reply-To: <44D8E709.2040705@sgi.com>
References: <44D8E709.2040705@sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Aug 2006 12:33:29 -0700
Jay Lan <jlan@sgi.com> wrote:

> ChangeLog:
>    Feedbacks from Andrew Morton:
>    - define TS_COMM_LEN to 32
>    - change acct_stimexpd field of task_struct to be of
>      cputime_t, which is to be used to save the tsk->stime
>      of last timer interrupt update.
>    - a new Documentation/accounting/taskstats-struct.txt
>      to describe fields of taskstats struct.
> 
>    Feedback from Balbir Singh:
>    - keep the stime of a task to be zero when both stime
>      and utime are zero as recoreded in task_struct.
> 
>    Misc:
>    - convert accumulated RSS/VM from platform dependent
>      pages-ticks to MBytes-usecs in the kernel

hm, lot of things, thanks.

Where does one go to obtain the userspace side of things so we can play
with this stuff?

