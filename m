Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263048AbTH0BPN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 21:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263049AbTH0BPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 21:15:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:49064 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263048AbTH0BPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 21:15:09 -0400
Date: Tue, 26 Aug 2003 18:18:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test4 -- add context switch counters
Message-Id: <20030826181807.1edb8c48.akpm@osdl.org>
In-Reply-To: <16204.520.61149.961640@wombat.disy.cse.unsw.edu.au>
References: <16204.520.61149.961640@wombat.disy.cse.unsw.edu.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb <peterc@gelato.unsw.edu.au> wrote:
>
> Currently, the context switch counters reported by getrusage() are
>  always zero.  The appended patch adds fields to struct task_struct to
>  count context switches, and adds code to do the counting.
>
>  The patch adds 4 longs to struct task struct, and a single addition to
>  the fast path in schedule().

OK...  Why is this useful?  A bit of googling doesn't show much interest in
it.

What apps should be reporting this info?  /usr/bin/time?


