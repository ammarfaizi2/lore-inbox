Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131539AbRACWX6>; Wed, 3 Jan 2001 17:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131591AbRACWXs>; Wed, 3 Jan 2001 17:23:48 -0500
Received: from zeus.kernel.org ([209.10.41.242]:50694 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131539AbRACWXj>;
	Wed, 3 Jan 2001 17:23:39 -0500
Date: Wed, 3 Jan 2001 23:36:10 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: mark@itsolve.co.uk
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking
 bug exploits
In-Reply-To: <Pine.LNX.4.21.0101032259550.20246-100000@callisto.yi.org>
Message-ID: <Pine.LNX.4.21.0101032335220.20766-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Dan Aloni wrote:

> +
> +void print_bad_syscall(struct task_struct *task)
> +{
> +	printk("process %s (%d) tried to syscall from an executable segment!\n", task->comm, task->pid);
> +}

Hmm, should be "writable segment", perhaps ;-)

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
