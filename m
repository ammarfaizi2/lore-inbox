Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750860AbWFEKIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWFEKIk (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 06:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWFEKIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 06:08:40 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:31694 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750860AbWFEKIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 06:08:39 -0400
Date: Mon, 5 Jun 2006 18:08:37 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 -mm merge plans
Message-ID: <20060605140837.GA80@oleg>
References: <20060604135011.decdc7c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060604135011.decdc7c9.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04, Andrew Morton wrote:
>
> de_thread-fix-lockless-do_each_thread.patch
> coredump-optimize-mm-users-traversal.patch
> coredump-speedup-sigkill-sending.patch
> coredump-kill-ptrace-related-stuff.patch
> coredump-kill-ptrace-related-stuff-fix.patch
> coredump-dont-take-tasklist_lock.patch
> coredump-some-code-relocations.patch
> coredump-shutdown-current-process-first.patch
> coredump-copy_process-dont-check-signal_group_exit.patch
>
>  Will merge.  I have a note here that Roland had issues with
>  coredump-kill-ptrace-related-stuff.patch?

Should be solved by coredump-kill-ptrace-related-stuff-fix.patch.
(There was no explicit ack from Roland though).

Oleg.

