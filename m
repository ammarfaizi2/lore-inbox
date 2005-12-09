Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbVLISxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbVLISxm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbVLISxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:53:42 -0500
Received: from ns.suse.de ([195.135.220.2]:51152 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932409AbVLISxl (ORCPT
	<rfc822;linux-kerneL@vger.kernel.org>);
	Fri, 9 Dec 2005 13:53:41 -0500
To: Ross Biro <ross.biro@gmail.com>
Cc: linux-kerneL@vger.kernel.org
Subject: Re: [PATCH 2.6.14] X86_64 delay resolution
References: <8783be660512090834l40b5c051p6c58676bccc834fc@mail.gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 09 Dec 2005 16:24:26 -0700
In-Reply-To: <8783be660512090834l40b5c051p6c58676bccc834fc@mail.gmail.com>
Message-ID: <p73slt1q2fp.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Biro <ross.biro@gmail.com> writes:

> On x86_64 smp systems, we noticed that the amount of time udelay would
> spin for varied from cpu to cpu.  In our test case, udelay(10) would
> only delay for 9.7us on some cpus while on others it would delay for
> the full 10us.  We tracked the problem down to an unnecessary attempt
> to avoid arithmetic overflow.  Here's a fix complete with an overly
> verbose comment.

I applied it without the comment and without the extra sets
of brackets. Please submit future x86-64 patches directly
to me and also Signed them off and use toplevel diffs.

Thanks,
-Andi
