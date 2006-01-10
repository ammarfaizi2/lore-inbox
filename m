Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWAJKr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWAJKr4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 05:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWAJKrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 05:47:55 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:30187 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932113AbWAJKrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 05:47:55 -0500
Date: Tue, 10 Jan 2006 11:47:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
Message-ID: <20060110104759.GA30546@elte.hu>
References: <20060107052221.61d0b600.akpm@osdl.org> <43BFD8C1.9030404@reub.net> <20060107133103.530eb889.akpm@osdl.org> <43C38932.7070302@reub.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C38932.7070302@reub.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Reuben Farrelly <reuben-lkml@reub.net> wrote:

> >Don't know, sorry.  But this kernel had oopsed, hadn't it?
> 
> This one is still present in -git6.  The symptoms are that the kernel 
> boots up, the userspace applications start launching as the system 
> starts to go to runlevel 3, and then the system 'blocks' on 
> $random_service (clamd, mysql and vsftp and others).  I've left it for 
> 5 mins and it never continued on..
> 
> There's no oops, and nothing seems to be logged about it, I can hit 
> enter and the console jumps to a new line, so the machine doesn't lock 
> up hard, it seems to be getting 'stuck'.

could you please also send me a SysRq-T (showTasks) output? [which will 
also include all the stacktraces] (Please make sure you have 
KALLSYMS_ALL enabled.)

	Ingo
